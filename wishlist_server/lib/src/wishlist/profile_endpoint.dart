import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';

import '../generated/protocol.dart';

/// The caller's first name, shown to the family. Accessed as `client.profile`.
//
// The auth module has a ready-made UserProfileEditBaseEndpoint, but it also
// exposes image uploads and accepts names of any length. We expose only what
// the app needs, with validation.
class ProfileEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// The caller's first name, or null if not chosen yet.
  Future<String?> getName(Session session) async {
    final me = session.authenticated!.authUserId;
    final profile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(me),
    );
    return profile?.userName;
  }

  Future<void> setName(Session session, String name) async {
    final trimmed = name.trim();
    if (trimmed.isEmpty || trimmed.length > 30) {
      throw WishlistException(
        message: 'Le prénom doit faire entre 1 et 30 caractères',
      );
    }
    await const UserProfiles().changeUserName(
      session,
      session.authenticated!.authUserId,
      trimmed,
    );
  }
}
