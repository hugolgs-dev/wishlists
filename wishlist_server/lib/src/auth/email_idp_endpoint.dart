import 'package:serverpod_auth_idp_server/providers/email.dart';
import 'package:serverpod/serverpod.dart';

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
class EmailIdpEndpoint extends EmailIdpBaseEndpoint {
  /// Only emails listed in the `familyEmails` password may sign up
  /// (ROADMAP: no public sign-up).
  //
  // Registration always begins with startRegistration: no request id means no
  // verification code, and without a code finishRegistration cannot succeed.
  // Guarding this one method is enough to close sign-up.
  @override
  Future<UuidValue> startRegistration(
    Session session, {
    required String email,
  }) async {
    final allowed = (session.passwords['familyEmails'] ?? '')
        .split(',')
        .map((e) => e.trim().toLowerCase());
    if (!allowed.contains(email.trim().toLowerCase())) {
      // The sign-in widget already knows how to display this exception.
      throw EmailAccountRequestException(
        reason: EmailAccountRequestExceptionReason.invalid,
      );
    }
    // `super` = run the original Serverpod implementation.
    return super.startRegistration(session, email: email);
  }
}
