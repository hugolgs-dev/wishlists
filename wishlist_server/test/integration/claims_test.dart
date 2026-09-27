import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';
import 'package:wishlist_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

import 'test_tools/serverpod_test_tools.dart';
import 'test_users.dart';

void main() {
  withServerpod('Given family and claims endpoints', (
    sessionBuilder,
    endpoints,
  ) {
    UuidValue idOf(TestSessionBuilder user) =>
        user.build().authenticated!.authUserId;

    test('when Bob claims Alice\'s item then Bob sees his claim', () async {
      final alice = await newUser(sessionBuilder);
      final bob = await newUser(sessionBuilder);
      final item = await endpoints.myWishlist.add(
        alice,
        WishItem(title: 'Scarf'),
      );

      await endpoints.claims.claim(bob, item.id!, 1);

      final list = await endpoints.family.list(bob, idOf(alice));
      expect(list.single.myQuantity, 1);
      expect(list.single.claims, hasLength(1));
    });

    test('when Alice opens her own family list then it fails', () async {
      final alice = await newUser(sessionBuilder);
      await expectLater(
        endpoints.family.list(alice, idOf(alice)),
        throwsA(isA<WishlistException>()),
      );
    });

    test('when Alice claims her own item then it fails', () async {
      final alice = await newUser(sessionBuilder);
      final item = await endpoints.myWishlist.add(
        alice,
        WishItem(title: 'Scarf'),
      );
      await expectLater(
        endpoints.claims.claim(alice, item.id!, 1),
        throwsA(isA<WishlistException>()),
      );
    });

    test('when claims exceed quantity then it fails', () async {
      final alice = await newUser(sessionBuilder);
      final bob = await newUser(sessionBuilder);
      final carol = await newUser(sessionBuilder);
      final item = await endpoints.myWishlist.add(
        alice,
        WishItem(title: 'Mug', quantity: 2),
      );

      await endpoints.claims.claim(bob, item.id!, 1);
      await endpoints.claims.claim(carol, item.id!, 1);
      await expectLater(
        endpoints.claims.claim(carol, item.id!, 2),
        throwsA(isA<WishlistException>()),
      );
    });

    test('when owner edits after claim then claimer is warned', () async {
      final alice = await newUser(sessionBuilder);
      final bob = await newUser(sessionBuilder);
      final item = await endpoints.myWishlist.add(
        alice,
        WishItem(title: 'Scarf'),
      );
      await endpoints.claims.claim(bob, item.id!, 1);

      await endpoints.myWishlist.update(
        alice,
        item.copyWith(title: 'Red scarf'),
      );

      final mine = await endpoints.claims.mine(bob);
      expect(mine.single.changedSinceMyClaim, isTrue);
    });

    test(
      'when owner removes a claimed item then only claimer sees it',
      () async {
        final alice = await newUser(sessionBuilder);
        final bob = await newUser(sessionBuilder);
        final carol = await newUser(sessionBuilder);
        final item = await endpoints.myWishlist.add(
          alice,
          WishItem(title: 'Scarf'),
        );
        await endpoints.claims.claim(bob, item.id!, 1);

        await endpoints.myWishlist.remove(alice, item.id!);

        final aliceId = idOf(alice);
        expect(
          (await endpoints.family.list(bob, aliceId)).single.removed,
          isTrue,
        );
        expect(await endpoints.family.list(carol, aliceId), isEmpty);
      },
    );

    test('when claimer marks it seen then the warning goes away', () async {
      final alice = await newUser(sessionBuilder);
      final bob = await newUser(sessionBuilder);
      final item = await endpoints.myWishlist.add(
        alice,
        WishItem(title: 'Scarf'),
      );
      await endpoints.claims.claim(bob, item.id!, 1);
      await endpoints.myWishlist.update(
        alice,
        item.copyWith(title: 'Red scarf'),
      );

      await endpoints.claims.markSeen(bob, item.id!);

      expect(
        (await endpoints.claims.mine(bob)).single.changedSinceMyClaim,
        isFalse,
      );
    });

    test('when marking purchased then shopping list shows it', () async {
      final alice = await newUser(sessionBuilder);
      final bob = await newUser(sessionBuilder);
      final item = await endpoints.myWishlist.add(
        alice,
        WishItem(title: 'Scarf'),
      );
      await endpoints.claims.claim(bob, item.id!, 1);

      await endpoints.claims.setPurchased(bob, item.id!, true);

      expect((await endpoints.claims.mine(bob)).single.myPurchased, isTrue);
    });
  });
}
