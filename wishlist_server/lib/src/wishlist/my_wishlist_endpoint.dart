// =============================================================================
// my_wishlist_endpoint.dart
//
// An ENDPOINT is a server class whose public methods the Flutter app can call
// over the network as if they were local functions.
//
// When this file is saved, `serverpod start` runs the code generator, which
// creates a matching method in the `wishlist_client` package. In Flutter:
//
//     final items = await client.myWishlist.list();
//
// Serverpod turns that call into an HTTP request, runs `list()` below,
// serializes the result to JSON, sends it back, and rebuilds
// `List<WishItem>` objects on the phone. No routes, no JSON code, no HTTP code.
//
// Client-side name = class name minus "Endpoint", in lowerCamelCase:
// MyWishlistEndpoint -> client.myWishlist
// =============================================================================

// The framework itself: Endpoint, Session, UuidValue, Expression, ...
import 'package:serverpod/serverpod.dart';

// The auth module. Needed here only for `.authUserId`, an extension getter
// on `session.authenticated` that returns the user's id as a UuidValue.
import 'package:serverpod_auth_idp_server/core.dart';

// Everything generated from the .spy.yaml files: Item, Event, WishItem,
// WishlistException, and the database helpers (Item.db, ItemTable, ...).
// NEVER edit generated code; it is rewritten on each generation.
import '../generated/protocol.dart';

// The single visibility rule (ownListFilter). Kept in its own file so every
// endpoint uses the same rule instead of re-implementing it.
import 'visibility.dart';

/// The signed-in user's own wishlist. Accessed as `client.myWishlist`.
//
// `extends Endpoint` is what makes the code generator treat this class as an
// endpoint and expose its public methods to the app.
class MyWishlistEndpoint extends Endpoint {
  // A guard Serverpod runs BEFORE any method of this class. If the request has
  // no valid sign-in token, Serverpod rejects it and our code never runs; the
  // app receives a ServerpodUnauthenticatedException.
  //
  // This is also why `session.authenticated!` below is safe: without
  // requireLogin, `authenticated` could be null and the `!` would crash.
  @override
  bool get requireLogin => true;

  // ---------------------------------------------------------------------------
  // How Serverpod decides a method is exposed to the app:
  //   1. it is public (its name does not start with `_`),
  //   2. its first parameter is `Session`,
  //   3. it returns a `Future`,
  //   4. all its parameter/return types can be sent over the network:
  //      built-in types, or .spy.yaml classes that are NOT `serverOnly`.
  //
  // `Item` is `serverOnly`, so it does not exist on the client and cannot
  // appear in a public method signature; the generator rejects it. We are
  // forced to go through `WishItem`, which has no claim fields.
  //
  // `Session` is created by Serverpod for each request; the app never passes it.
  // It holds who is calling (session.authenticated) and database access
  // (used by the generated Item.db / Event.db helpers).
  // ---------------------------------------------------------------------------

  /// Returns the caller's own items, high priority first.
  Future<List<WishItem>> list(Session session) async {
    // The caller's user id (a UUID, the same as serverpod_auth_core_user.id),
    // read from the VERIFIED sign-in token. The app cannot fake it.
    //
    // Most important security habit in this file: "who am I" always comes
    // from the session, NEVER from a parameter. If this method took a
    // `userId` parameter, anyone could pass someone else's id.
    final me = session.authenticated!.authUserId;

    // Item.db.find = generated "SELECT ... FROM item".
    //
    // `where: (t) => ...` looks like a Dart filter but is not one: `t` is an
    // ItemTable, a description of the table's columns. Calls like
    // `t.ownerId.equals(me)` build SQL (`"ownerId" = ?`) instead of comparing
    // values in Dart. The filtering happens IN THE DATABASE, so other people's
    // rows never even reach server memory.
    final items = await Item.db.find(
      session,
      // Owner is me AND I created it AND it is not deleted.
      // "I created it" hides secret ideas that others added about me.
      where: (t) => ownListFilter(t, me),
      // Ascending: priority 1 (high) comes first.
      orderBy: (t) => t.priority,
    );

    // Convert each database row (Item) into the shape sent to the app
    // (WishItem). Everything that leaves the server goes through _toWishItem.
    return items.map(_toWishItem).toList();
  }

  /// Creates a new item on the caller's list.
  Future<WishItem> add(Session session, WishItem input) async {
    // `input` comes from the app, so treat it as UNTRUSTED: the app may have a
    // bug, or someone may send hand-made requests with curl, since the API is
    // public on the internet. Reject bad data before touching the database.
    _validate(input);

    final me = session.authenticated!.authUserId;

    // The event is looked up on the server, not taken from the client.
    final event = await _currentEvent(session);

    // Build the new row field by field, taking ONLY the user-editable fields
    // from `input`. ownerId, createdById and eventId are set by the server.
    // Even a modified client cannot set them: WishItem has no such fields.
    final item = await Item.db.insertRow(
      session,
      Item(
        // A model's `id` is `int?` because an unsaved object has no id yet.
        // An event loaded from the database always has one, so `!` is safe.
        eventId: event.id!,
        ownerId: me,
        createdById: me,
        // trim() removes leading/trailing spaces: "  Scarf " -> "Scarf".
        title: input.title.trim(),
        notes: input.notes,
        url: input.url,
        priceCents: input.priceCents,
        priority: input.priority,
        quantity: input.quantity,
        // Fields not passed here (createdAt, updatedAt, isGroupGift, ...) get
        // their defaults from item.spy.yaml (`default=now`, `default=false`),
        // or stay null (deletedAt, organizerId, ...).
      ),
    );

    // insertRow returns the saved row, now with its database-assigned `id`.
    // The app needs that id to edit or delete the item later.
    return _toWishItem(item);
  }

  /// Edits one of the caller's items.
  Future<WishItem> update(Session session, WishItem input) async {
    _validate(input);

    // `input.id` comes from the app, so it is untrusted: anyone could send
    // `id: 42` for an item that belongs to Mom. _findMine loads the item ONLY
    // if it is ours, and throws otherwise. The ownership check is part of the
    // database query itself; there is no separate "check the owner" step that
    // could be forgotten.
    final item = await _findMine(session, input.id);

    // updateRow writes the row back, matched by its `id`.
    final updated = await Item.db.updateRow(
      session,
      // copyWith = a copy of `item` (the REAL row from the database) with some
      // fields replaced. Fields not listed (ownerId, eventId, createdAt, ...)
      // keep their database values, so the client cannot change them.
      //
      // Passing null really clears a field: `copyWith(notes: null)` sets notes
      // to null. Serverpod's generated copyWith tells "passed null" apart
      // from "not passed".
      item.copyWith(
        title: input.title.trim(),
        notes: input.notes,
        url: input.url,
        priceCents: input.priceCents,
        priority: input.priority,
        quantity: input.quantity,
        // Drives the "changed since you claimed it" warning (ROADMAP):
        // a claimer is warned when item.updatedAt > claim.createdAt.
        // ponytail: any save counts as a meaningful edit; compare fields if
        // priority-only changes start flagging claims needlessly.
        updatedAt: DateTime.now(),
      ),
    );
    return _toWishItem(updated);
  }

  /// Soft delete, so claimers see "removed by owner".
  //
  // The row is NOT deleted: `deletedAt` gets a timestamp. ownListFilter hides
  // rows where deletedAt is set, so the item disappears from the owner's list,
  // while the row stays in the database. In step 4, someone who claimed it
  // can then see "removed by owner" instead of their claim silently vanishing
  // (a ROADMAP edge case).
  //
  // Calling it twice is harmless: the second call finds nothing (already
  // deleted) and throws "not found".
  Future<void> remove(Session session, int id) async {
    final item = await _findMine(session, id);
    await Item.db.updateRow(session, item.copyWith(deletedAt: DateTime.now()));
  }

  // ---------------------------------------------------------------------------
  // Private helpers. The leading `_` makes them private in Dart, and Serverpod
  // does NOT expose private methods to the app. They are helpers, not API.
  // ---------------------------------------------------------------------------

  /// Loads an item only if it belongs to the caller; throws otherwise.
  //
  // `id` is `int?` because WishItem.id is nullable: the same class is used for
  // new items, which have no id yet. Calling update without an id counts as
  // "not found".
  Future<Item> _findMine(Session session, int? id) async {
    final me = session.authenticated!.authUserId;
    final item = id == null
        ? null
        : await Item.db.findFirstRow(
            session,
            // This id AND it is mine. `&` between conditions becomes SQL AND.
            where: (t) => t.id.equals(id) & ownListFilter(t, me),
          );

    // Same error for "does not exist" and "belongs to someone else", ON
    // PURPOSE. If the error said "not yours", Bob could try ids 1, 2, 3... and
    // learn which items exist. With one answer, he learns nothing.
    //
    // WishlistException is defined in YAML (`exception:`), so Serverpod sends
    // it to the app with its message. The app can catch it:
    //     try { ... } on WishlistException catch (e) { show(e.message); }
    // Any OTHER uncaught error reaches the app as a generic server error with
    // no details, which is what we want for unexpected bugs.
    if (item == null) throw WishlistException(message: 'Article introuvable');
    return item;
  }

  /// Rejects invalid data coming from the client.
  //
  // The Flutter form should validate too, for friendly messages. This server
  // check is the one that actually protects the data, because the client can
  // always be bypassed.
  void _validate(WishItem input) {
    // Copying the field into a local variable lets Dart know it is non-null
    // after `url != null`, which it cannot assume for a field on an object.
    final url = input.url;

    if (
    // An item with no name.
    input.title.trim().isEmpty ||
        // Priority outside the ROADMAP's 1–3 scale.
        input.priority < 1 ||
        input.priority > 3 ||
        // Zero or negative quantities would break the future
        // SUM(claims.quantity) <= items.quantity check.
        input.quantity < 1 ||
        // Negative price. `?? 0` means "no price is fine".
        (input.priceCents ?? 0) < 0 ||
        // SECURITY: only http/https links. Other family members will tap
        // these links. Without this check someone could save
        // `javascript:...` or `file:///...`, and link previews (a later
        // feature) would fetch arbitrary schemes.
        (url != null && !url.startsWith(RegExp(r'https?://')))) {
      throw WishlistException(message: 'Article non valide');
    }
  }

  /// Returns the active event, creating `Christmas <year>` on first use.
  //
  // The ROADMAP allows a single event for the MVP. Get-or-create avoids a
  // seeding script or an admin screen.
  //
  // Known limit: if two people add their very first item at the same instant,
  // two events could be created. Very unlikely with 4–5 users, easy to clean.
  // ponytail: one active event, created on first use. Add event management
  // when a second event (birthdays, next Christmas) is needed.
  Future<Event> _currentEvent(Session session) async {
    final existing = await Event.db.findFirstRow(
      session,
      where: (t) => t.archived.equals(false),
      // Earliest non-archived event.
      orderBy: (t) => t.date,
    );
    if (existing != null) return existing;

    final year = DateTime.now().year;
    return Event.db.insertRow(
      session,
      Event(name: 'Noël $year', date: DateTime(year, 12, 25)),
    );
  }
}

/// Converts a database row into what the owner is allowed to see.
//
// Defined outside the class: a plain function, private to this file (`_`).
//
// This is the gate for outgoing data. It copies fields ONE BY ONE instead of
// sending the Item, so the fields it leaves out never reach the app: ownerId,
// createdById, deletedAt and, in the future, anything about claims. When
// step 4 adds claim data for OTHER people's lists, it will use a different
// class and mapping. The owner's view can never include claim fields,
// because WishItem does not have them.
WishItem _toWishItem(Item item) => WishItem(
  id: item.id,
  title: item.title,
  notes: item.notes,
  url: item.url,
  priceCents: item.priceCents,
  priority: item.priority,
  quantity: item.quantity,
);
