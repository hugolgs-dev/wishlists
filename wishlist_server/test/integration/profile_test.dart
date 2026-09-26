import 'package:test/test.dart';
import 'package:wishlist_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';
import 'test_users.dart';

void main() {
  withServerpod('Given Profile endpoint', (sessionBuilder, endpoints) {
    test('when setting a name then it is returned trimmed', () async {
      final alice = await newUser(sessionBuilder);
      expect(await endpoints.profile.getName(alice), isNull);

      await endpoints.profile.setName(alice, '  Alice ');

      expect(await endpoints.profile.getName(alice), 'Alice');
    });

    test('when the name is blank or too long then it fails', () async {
      final alice = await newUser(sessionBuilder);
      for (final name in ['   ', 'a' * 31]) {
        await expectLater(
          endpoints.profile.setName(alice, name),
          throwsA(isA<WishlistException>()),
        );
      }
    });

    test('when set then the family sees it', () async {
      final alice = await newUser(sessionBuilder);
      final bob = await newUser(sessionBuilder);
      await endpoints.profile.setName(alice, 'Alice');

      final members = await endpoints.family.members(bob);
      expect(members.map((m) => m.name), contains('Alice'));
    });
  });
}
