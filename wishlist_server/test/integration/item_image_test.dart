import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:test/test.dart';
import 'package:wishlist_server/src/generated/protocol.dart';

import 'test_tools/serverpod_test_tools.dart';
import 'test_users.dart';

void main() {
  withServerpod('Given item pictures', (sessionBuilder, endpoints) {
    final png = Uint8List.fromList([0x89, 0x50, 0x4E, 0x47, 0, 0, 0, 0]);
    final text = Uint8List.fromList('not an image'.codeUnits);

    // Simulates the app's upload the way Serverpod's upload route stores it:
    // unverified until attachImage calls verifyUpload.
    Future<void> store(String path, Uint8List bytes) =>
        DatabaseCloudStorage('public').storeUnverifiedFile(
          session: sessionBuilder.build(),
          path: path,
          byteData: ByteData.sublistView(bytes),
        );

    test('when a PNG is attached then the item has an image URL', () async {
      final alice = await newUser(sessionBuilder);
      final item = await endpoints.myWishlist.add(
        alice,
        WishItem(title: 'Mug'),
      );
      final upload = await endpoints.myWishlist.imageUpload(alice, item.id!);
      await store(upload.path, png);

      final updated = await endpoints.myWishlist.attachImage(
        alice,
        item.id!,
        upload.path,
      );

      expect(updated.imageUrl, isNotNull);
    });

    test('when the picture is removed then the URL is gone', () async {
      final alice = await newUser(sessionBuilder);
      final item = await endpoints.myWishlist.add(
        alice,
        WishItem(title: 'Mug'),
      );
      final upload = await endpoints.myWishlist.imageUpload(alice, item.id!);
      await store(upload.path, png);
      await endpoints.myWishlist.attachImage(alice, item.id!, upload.path);

      final updated = await endpoints.myWishlist.removeImage(alice, item.id!);

      expect(updated.imageUrl, isNull);
    });

    test('when the file is not an image then it is refused', () async {
      final alice = await newUser(sessionBuilder);
      final item = await endpoints.myWishlist.add(
        alice,
        WishItem(title: 'Mug'),
      );
      final upload = await endpoints.myWishlist.imageUpload(alice, item.id!);
      await store(upload.path, text);

      await expectLater(
        endpoints.myWishlist.attachImage(alice, item.id!, upload.path),
        throwsA(isA<WishlistException>()),
      );
    });

    test('when Bob asks to upload on Alice\'s item then it fails', () async {
      final alice = await newUser(sessionBuilder);
      final bob = await newUser(sessionBuilder);
      final item = await endpoints.myWishlist.add(
        alice,
        WishItem(title: 'Mug'),
      );

      await expectLater(
        endpoints.myWishlist.imageUpload(bob, item.id!),
        throwsA(isA<WishlistException>()),
      );
    });

    test('when the path belongs to another item then it is refused', () async {
      final alice = await newUser(sessionBuilder);
      final mug = await endpoints.myWishlist.add(alice, WishItem(title: 'Mug'));
      final scarf = await endpoints.myWishlist.add(
        alice,
        WishItem(title: 'Scarf'),
      );
      final upload = await endpoints.myWishlist.imageUpload(alice, mug.id!);
      await store(upload.path, png);

      await expectLater(
        endpoints.myWishlist.attachImage(alice, scarf.id!, upload.path),
        throwsA(isA<WishlistException>()),
      );
    });

    test('when the family views the item then they see the picture', () async {
      final alice = await newUser(sessionBuilder);
      final bob = await newUser(sessionBuilder);
      final item = await endpoints.myWishlist.add(
        alice,
        WishItem(title: 'Mug'),
      );
      final upload = await endpoints.myWishlist.imageUpload(alice, item.id!);
      await store(upload.path, png);
      await endpoints.myWishlist.attachImage(alice, item.id!, upload.path);

      final aliceId = alice.build().authenticated!.authUserId;
      final list = await endpoints.family.list(bob, aliceId);

      expect(list.single.imageUrl, isNotNull);
    });
  });
}
