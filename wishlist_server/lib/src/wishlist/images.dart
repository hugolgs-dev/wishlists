import 'dart:math';
import 'dart:typed_data';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Item pictures live in the 'public' storage: anyone with the URL can open
/// them, so every path contains a random part that can't be guessed.
// ponytail: public storage + random path. Switch to 'private' storage with
// session.storage.temporaryDownloadUrl if pictures ever become sensitive.
const imageStorage = 'public';

/// Same as `maxRequestSize` in config: bigger uploads would be refused anyway.
const maxImageBytes = 512 * 1024;

/// `items/<itemId>/<32 random hex characters>`
String newImagePath(int itemId) {
  final random = Random.secure(); // cryptographically secure, not guessable
  final token = [
    for (var i = 0; i < 16; i++)
      random.nextInt(256).toRadixString(16).padLeft(2, '0'),
  ].join();
  return 'items/$itemId/$token';
}

/// The URL the app loads the picture from, or null if there is none.
Future<String?> imageUrlOf(Session session, Item item) async {
  final path = item.imagePath;
  if (path == null) return null;
  final url = await session.storage.publicDownloadUrl(
    storageId: imageStorage,
    path: path,
  );
  return url.toString();
}

/// Checks the file's first bytes (its "magic number"): JPEG, PNG or WebP.
/// The file name or type the app claims is never trusted.
bool looksLikeImage(Uint8List bytes) {
  bool matches(List<int> signature, [int offset = 0]) {
    if (bytes.length < offset + signature.length) return false;
    for (var i = 0; i < signature.length; i++) {
      if (bytes[offset + i] != signature[i]) return false;
    }
    return true;
  }

  return matches([0xFF, 0xD8, 0xFF]) || // JPEG
      matches([0x89, 0x50, 0x4E, 0x47]) || // PNG
      // WebP: "RIFF", 4 bytes of size, then "WEBP"
      (matches([0x52, 0x49, 0x46, 0x46]) &&
          matches([0x57, 0x45, 0x42, 0x50], 8));
}
