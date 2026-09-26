import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';
import 'package:wishlist_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given MyWishlist endpoint', (sessionBuilder, endpoints) {
    // Items reference real auth users (foreign key), so create them.
    Future<TestSessionBuilder> newUser() async {
      final user = await const AuthUsers().create(sessionBuilder.build());
      return sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          user.id.uuid,
          {},
        ),
      );
    }

    test('when adding an item then it is listed', () async {
      final alice = await newUser();
      await endpoints.myWishlist.add(alice, WishItem(title: 'Scarf'));

      final items = await endpoints.myWishlist.list(alice);
      expect(items.map((i) => i.title), ['Scarf']);
    });

    test('when another user lists then they do not see it', () async {
      final alice = await newUser();
      final bob = await newUser();
      await endpoints.myWishlist.add(alice, WishItem(title: 'Scarf'));

      expect(await endpoints.myWishlist.list(bob), isEmpty);
    });

    test('when another user updates or removes it then it fails', () async {
      final alice = await newUser();
      final bob = await newUser();
      final item = await endpoints.myWishlist.add(
        alice,
        WishItem(title: 'Scarf'),
      );

      await expectLater(
        endpoints.myWishlist.update(bob, item.copyWith(title: 'Hacked')),
        throwsA(isA<WishlistException>()),
      );
      await expectLater(
        endpoints.myWishlist.remove(bob, item.id!),
        throwsA(isA<WishlistException>()),
      );
    });

    test('when removed then it is no longer listed', () async {
      final alice = await newUser();
      final item = await endpoints.myWishlist.add(
        alice,
        WishItem(title: 'Scarf'),
      );
      await endpoints.myWishlist.remove(alice, item.id!);

      expect(await endpoints.myWishlist.list(alice), isEmpty);
    });

    test('when the title is blank then add fails', () async {
      final alice = await newUser();
      await expectLater(
        endpoints.myWishlist.add(alice, WishItem(title: '  ')),
        throwsA(isA<WishlistException>()),
      );
    });

    test('when signed out then list fails', () async {
      await expectLater(
        endpoints.myWishlist.list(sessionBuilder),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );
    });
  });
}
