import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
// UserFacingException is internal to the package (not exported), but it's the
// only way to reach the original error and translate it.
// ponytail: re-check this import when upgrading Serverpod; it may move.
// ignore: implementation_imports
import 'package:serverpod_auth_idp_flutter/src/common/exceptions.dart';

import '../client.dart';

class SignInScreen extends StatefulWidget {
  final Widget child;
  const SignInScreen({super.key, required this.child});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    client.auth.authInfoListenable.addListener(_updateSignedInState);
    _isSignedIn = client.auth.isAuthenticated;
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_updateSignedInState);
    super.dispose();
  }

  void _updateSignedInState() {
    setState(() {
      _isSignedIn = client.auth.isAuthenticated;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return _isSignedIn
        ? widget.child
        : Center(
            child: SignInLocalizationProvider(
              basic: _basicTextsFr,
              email: _emailTextsFr,
              passwordRequirementTexts: _passwordTextsFr,
              child: SignInWidget(
                client: client,
                onAuthenticated: () {},
                onError: (error) {
                  context.showSnackBar(
                    message: _frenchError(error),
                    backgroundColor: colors.errorContainer,
                    foregroundColor: colors.onErrorContainer,
                  );
                },
              ),
            ),
          );
  }
}

extension on BuildContext {
  void showSnackBar({
    required String message,
    required Color backgroundColor,
    required Color foregroundColor,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: foregroundColor)),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 5),
      ),
    );
  }
}

const _basicTextsFr = BasicSignInTexts(
  noAuthenticationProvidersConfigured: 'Aucune méthode de connexion configurée',
  orContinueWith: 'ou continuer avec',
);

const _emailTextsFr = EmailSignInTexts(
  title: 'Connexion',
  forgotPassword: 'Mot de passe oublié ?',
  signIn: 'Se connecter',
  dontHaveAnAccount: 'Pas encore de compte ?',
  signUp: "S'inscrire",
  signUpTitle: 'Inscription',
  continueAction: 'Continuer',
  alreadyHaveAnAccount: 'Déjà un compte ?',
  verifyAccountTitle: 'Vérification',
  verifyResetCodeTitle: 'Vérification du code',
  verificationMessage:
      'Un e-mail vous a été envoyé. Saisissez le code reçu ci-dessous.',
  verify: 'Vérifier',
  setAccountPasswordTitle: 'Choisissez un mot de passe',
  passwordLabel: 'Mot de passe',
  backToSignUp: "Retour à l'inscription",
  setNewPasswordTitle: 'Nouveau mot de passe',
  newPasswordLabel: 'Nouveau mot de passe',
  resetPasswordTitle: 'Mot de passe oublié',
  resetPasswordDescription:
      'Saisissez votre adresse e-mail pour réinitialiser votre mot de passe.',
  requestPasswordReset: 'Envoyer le code',
  resetPassword: 'Réinitialiser',
  backToSignIn: 'Retour à la connexion',
  emailLabel: 'E-mail',
  termsIntro: "J'ai lu et j'accepte les ",
  termsAndConditions: "conditions d'utilisation",
  andText: ' et la ',
  privacyPolicy: 'politique de confidentialité',
);

const _passwordTextsFr = PasswordRequirementTexts(
  minLengthTemplate: 'Au moins {length} caractères',
  maxLengthTemplate: 'Au plus {length} caractères',
  containsLowercase: 'Au moins une minuscule',
  containsUppercase: 'Au moins une majuscule',
  containsNumber: 'Au moins un chiffre',
  containsSpecialCharacter: 'Au moins un caractère spécial',
);

/// The auth package's error messages are English-only, so map the server's
/// error reasons to French ourselves.
String _frenchError(Object error) {
  final original = error is UserFacingException
      ? error.originalException
      : error;
  return switch (original) {
    EmailAccountLoginException(
      reason: EmailAccountLoginExceptionReason.invalidCredentials,
    ) =>
      'E-mail ou mot de passe incorrect.',
    EmailAccountLoginException(
      reason: EmailAccountLoginExceptionReason.tooManyAttempts,
    ) ||
    EmailAccountRequestException(
      reason: EmailAccountRequestExceptionReason.tooManyAttempts,
    ) => 'Trop de tentatives. Réessayez dans quelques minutes.',
    EmailAccountRequestException(
      reason: EmailAccountRequestExceptionReason.expired,
    ) =>
      'Ce code a expiré. Demandez-en un nouveau.',
    // Also what the family allowlist sends for an unknown email (step 5).
    EmailAccountRequestException(
      reason: EmailAccountRequestExceptionReason.invalid,
    ) =>
      'Code invalide, ou adresse e-mail non autorisée.',
    EmailAccountRequestException(
      reason: EmailAccountRequestExceptionReason.policyViolation,
    ) =>
      'Ce mot de passe ne respecte pas les règles.',
    _ => 'La connexion a échoué. Réessayez.',
  };
}
