import 'package:flutter_test/flutter_test.dart';
import 'package:wishlist_client/wishlist_client.dart';
import 'package:wishlist_flutter/screens/family_item_tile.dart';

void main() {
  FamilyItem mug({required int myQuantity, required List<int> claims}) =>
      FamilyItem(
        id: 1,
        ownerId: UuidValue.fromString('00000000-0000-4000-8000-000000000000'),
        ownerName: 'Alice',
        title: 'Mug',
        priority: 2,
        quantity: 3,
        claims: [
          for (final q in claims)
            ClaimInfo(
              claimerId: UuidValue.fromString(
                '00000000-0000-4000-8000-000000000001',
              ),
              claimerName: 'Bob',
              quantity: q,
            ),
        ],
        removed: false,
        changedSinceMyClaim: false,
        myQuantity: myQuantity,
        myPurchased: false,
      );

  test('available counts only other people\'s claims', () {
    // 3 mugs; someone else took 1, I took 1 -> I may hold up to 2.
    final item = mug(myQuantity: 1, claims: [1, 1]);
    expect(item.claimedByOthers, 1);
    expect(item.available, 2);
  });

  test('nothing available when others took everything', () {
    expect(mug(myQuantity: 0, claims: [3]).available, 0);
  });
}
