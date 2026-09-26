import 'package:serverpod_auth_idp_server/core.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Creates a real auth user and returns a session signed in as them.
Future<TestSessionBuilder> newUser(TestSessionBuilder sessionBuilder) async {
  final session = sessionBuilder.build();
  final user = await const AuthUsers().create(session);
  // Real email sign-ups create a profile holding the email; mimic that.
  await const UserProfiles().createUserProfile(
    session,
    user.id,
    UserProfileData(email: '${user.id.uuid}@test.local'),
  );
  return sessionBuilder.copyWith(
    authentication: AuthenticationOverride.authenticationInfo(
      user.id.uuid,
      {},
    ),
  );
}
