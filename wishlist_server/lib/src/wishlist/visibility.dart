import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

// =============================================================================
// THE visibility policy (ROADMAP "Core visibility rule"). Every endpoint that
// reads items or claims goes through these functions, so the rule lives in
// exactly one place.
// =============================================================================

/// Items shown on [userId]'s own list: ones they created for themselves.
/// Secret ideas about them (createdById != ownerId) are excluded.
Expression ownListFilter(ItemTable t, UuidValue userId) =>
    t.ownerId.equals(userId) &
    t.createdById.equals(userId) &
    t.deletedAt.equals(null);

/// Items [me] may see on OTHER people's lists: never my own items; deleted
/// items only if I claimed them (so I see "removed by owner").
Expression familyItemFilter(
  ItemTable t,
  UuidValue me, {
  Set<int> myClaimedItemIds = const {},
}) {
  var visible = t.deletedAt.equals(null);
  // `inSet` = SQL `IN (...)`. Skipped when empty to avoid an empty IN ().
  if (myClaimedItemIds.isNotEmpty) {
    visible = visible | t.id.inSet(myClaimedItemIds);
  }
  return t.ownerId.notEquals(me) & visible;
}

/// Builds the non-owner view of [items], claims included.
///
/// Second safety net: even if a caller passes [me]'s own items by mistake,
/// they are dropped here, so claim data can never be built for its owner.
Future<List<FamilyItem>> toFamilyItems(
  Session session,
  List<Item> items,
  UuidValue me,
) async {
  final visible = items.where((i) => i.ownerId != me).toList();
  if (visible.isEmpty) return [];

  // One query for all claims of all these items (not one query per item).
  final claims = await Claim.db.find(
    session,
    where: (t) => t.itemId.inSet({for (final i in visible) i.id!}),
  );
  final names = await _names(session, {
    for (final i in visible) i.ownerId,
    for (final c in claims) c.claimerId,
  });

  return [
    for (final item in visible)
      _toFamilyItem(
        item,
        claims.where((c) => c.itemId == item.id).toList(),
        names,
        me,
      ),
  ];
}

/// Name shown for a user: full name, then nickname, then email.
String displayName(UserProfile p) =>
    p.userName ?? p.fullName ?? p.email ?? "Quelqu'un";

FamilyItem _toFamilyItem(
  Item item,
  List<Claim> itemClaims,
  Map<UuidValue, String> names,
  UuidValue me,
) {
  final mine = itemClaims.where((c) => c.claimerId == me).firstOrNull;
  return FamilyItem(
    id: item.id!,
    ownerId: item.ownerId,
    ownerName: names[item.ownerId] ?? "Quelqu'un",
    title: item.title,
    notes: item.notes,
    url: item.url,
    priceCents: item.priceCents,
    priority: item.priority,
    quantity: item.quantity,
    claims: [
      for (final c in itemClaims)
        ClaimInfo(
          claimerId: c.claimerId,
          claimerName: names[c.claimerId] ?? "Quelqu'un",
          quantity: c.quantity,
        ),
    ],
    removed: item.deletedAt != null,
    // ROADMAP: items.updated_at > claims.created_at.
    changedSinceMyClaim: mine != null && item.updatedAt.isAfter(mine.createdAt),
    myQuantity: mine?.quantity ?? 0,
    myPurchased: mine?.purchased ?? false,
  );
}

/// Display names for a set of users, in one query.
Future<Map<UuidValue, String>> _names(
  Session session,
  Set<UuidValue> userIds,
) async {
  final profiles = await UserProfile.db.find(
    session,
    where: (t) => t.authUserId.inSet(userIds),
  );
  return {for (final p in profiles) p.authUserId: displayName(p)};
}
