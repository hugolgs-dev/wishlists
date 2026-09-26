import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given email sign-up', (sessionBuilder, endpoints) {
    test('when email is not in the family list then it is refused', () async {
      await expectLater(
        endpoints.emailIdp.startRegistration(
          sessionBuilder,
          email: 'stranger@example.com',
        ),
        throwsA(isA<EmailAccountRequestException>()),
      );
    });
  });
}
