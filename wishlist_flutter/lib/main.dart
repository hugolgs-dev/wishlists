import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'client.dart';
import 'screens/home_shell.dart';
import 'screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();
  runApp(const WishlistApp());
}

ThemeData _buildTheme(Brightness brightness) => ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.red,
    brightness: brightness,
  ),
);

class WishlistApp extends StatelessWidget {
  const WishlistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liste de Noël',
      locale: const Locale('fr'),
      supportedLocales: const [Locale('fr')],
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: _buildTheme(Brightness.light),
      darkTheme: _buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      // SignInScreen shows the sign-in form until the user is signed in,
      // then its child. Signing out switches back automatically.
      home: const Scaffold(body: SignInScreen(child: HomeShell())),
    );
  }
}
