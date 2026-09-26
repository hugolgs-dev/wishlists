import 'package:serverpod_auth_idp_server/core.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Creates a real auth user and returns a session signed in as them.
Future<TestSessionBuilder> newUser(TestSessionBuilder sessionBuilder) async {
  final user = await const AuthUsers().create(sessionBuilder.build());
  return sessionBuilder.copyWith(
    authentication: AuthenticationOverride.authenticationInfo(
      user.id.uuid,
      {},
    ),
  );
}
