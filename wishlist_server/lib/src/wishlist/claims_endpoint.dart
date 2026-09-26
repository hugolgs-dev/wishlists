import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'visibility.dart';

/// Claiming gifts and the caller's shopping list. Accessed as `client.claims`.
class ClaimsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Claims [quantity] of an item, or changes the caller's existing claim.
  Future<void> claim(Session session, int itemId, int quantity) async {
    final me = session.authenticated!.authUserId;
    if (quantity < 1) throw WishlistException(message: 'Quantité non valide');

    // TRANSACTION: every query inside runs as one unit. If anything throws,
    // nothing is saved. SQLite also lets only one write transaction run at a
    // time, so two people claiming the last mug at the same instant are
    // handled one after the other: the second one sees the first claim and
    // gets "not enough left".
    // Pass `transaction: tx` to EVERY db call inside, or it runs outside.
    await session.db.transaction((tx) async {
      // familyItemFilter excludes my own items -> "can't claim own items",
      // and deleted items -> can't claim something removed.
      final item = await Item.db.findFirstRow(
        session,
        where: (t) => t.id.equals(itemId) & familyItemFilter(t, me),
        transaction: tx,
      );
      if (item == null) throw WishlistException(message: 'Article non trouvé');

      // ROADMAP: SUM(claims.quantity) <= items.quantity, checked here
      // because SQLite cannot express it as a constraint.
      final others = await Claim.db.find(
        session,
        where: (t) => t.itemId.equals(itemId) & t.claimerId.notEquals(me),
        transaction: tx,
      );
      final taken = others.fold(0, (sum, c) => sum + c.quantity);
      if (taken + quantity > item.quantity) {
        throw WishlistException(message: "Il n'en reste plus assez...");
      }

      // "Upsert": update my claim if I have one, insert otherwise. The
      // UNIQUE (itemId, claimerId) index guarantees at most one per person.
      final existing = await Claim.db.findFirstRow(
        session,
        where: (t) => t.itemId.equals(itemId) & t.claimerId.equals(me),
        transaction: tx,
      );
      if (existing == null) {
        await Claim.db.insertRow(
          session,
          Claim(itemId: itemId, claimerId: me, quantity: quantity),
          transaction: tx,
        );
      } else {
        await Claim.db.updateRow(
          session,
          existing.copyWith(quantity: quantity),
          transaction: tx,
        );
      }
    });
  }

  /// Drops the caller's claim. Allowed on removed items too.
  Future<void> unclaim(Session session, int itemId) async {
    final me = session.authenticated!.authUserId;
    await Claim.db.deleteWhere(
      session,
      where: (t) => t.itemId.equals(itemId) & t.claimerId.equals(me),
    );
  }

  /// The caller's shopping list: everything they claimed, across all lists.
  Future<List<FamilyItem>> mine(Session session) async {
    final me = session.authenticated!.authUserId;
    final claims = await Claim.db.find(
      session,
      where: (t) => t.claimerId.equals(me),
    );
    if (claims.isEmpty) return [];

    final items = await Item.db.find(
      session,
      where: (t) => t.id.inSet(<int>{for (final c in claims) c.itemId}),
    );
    return toFamilyItems(session, items, me);
  }

  /// Ticks or unticks "bought" on the caller's claim.
  Future<void> setPurchased(Session session, int itemId, bool purchased) async {
    final me = session.authenticated!.authUserId;
    final claim = await Claim.db.findFirstRow(
      session,
      where: (t) => t.itemId.equals(itemId) & t.claimerId.equals(me),
    );
    if (claim == null) throw WishlistException(message: 'Achat introuvable');
    await Claim.db.updateRow(session, claim.copyWith(purchased: purchased));
  }
}
