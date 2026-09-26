import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';
import 'visibility.dart';

/// Other family members and their lists. Accessed as `client.family`.
class FamilyEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// Everyone except the caller, for the overview screen.
  Future<List<Member>> members(Session session) async {
    final me = session.authenticated!.authUserId;
    final profiles = await UserProfile.db.find(
      session,
      where: (t) => t.authUserId.notEquals(me),
    );
    final members = [
      for (final p in profiles)
        Member(userId: p.authUserId, name: displayName(p)),
    ]..sort((a, b) => a.name.compareTo(b.name));
    return members;
  }

  /// One person's list, as seen by everyone except that person.
  Future<List<FamilyItem>> list(Session session, UuidValue ownerId) async {
    final me = session.authenticated!.authUserId;
    // Rule: the owner never sees claims. Their own list is myWishlist.list.
    if (ownerId == me) {
      throw WishlistException(
        message: 'Votre propre liste est dans "ma liste"',
      );
    }

    // Items I claimed, so deleted ones still show as "removed by owner".
    final myClaims = await Claim.db.find(
      session,
      where: (t) => t.claimerId.equals(me),
    );

    final items = await Item.db.find(
      session,
      where: (t) =>
          t.ownerId.equals(ownerId) &
          familyItemFilter(
            t,
            me,
            myClaimedItemIds: {for (final c in myClaims) c.itemId},
          ),
      orderBy: (t) => t.priority,
    );
    return toFamilyItems(session, items, me);
  }
}
