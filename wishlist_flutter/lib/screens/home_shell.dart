import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import 'my_wishlist_screen.dart';
import 'family_screen.dart';
import 'my_claims_screen.dart';
import '../async_ui.dart';
import 'name_dialog.dart';

enum _MenuAction { changeName, signOut }

/// The signed-in app: three tabs at the bottom, sign-out at the top.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  var _tab = 0;
  static const _titles = ['Mes idées', 'Famille', 'Mes achats'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_tab]),
        actions: [
          PopupMenuButton<_MenuAction>(
            onSelected: (action) => switch (action) {
              _MenuAction.changeName => _changeName(),
              // SignInScreen listens to auth changes and shows the sign-in form.
              _MenuAction.signOut => client.auth.signOutDevice(),
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: _MenuAction.changeName,
                child: Text('Changer mon prénom'),
              ),
              PopupMenuItem(
                value: _MenuAction.signOut,
                child: Text('Se déconnecter'),
              ),
            ],
          ),
        ],
      ),
      body: switch (_tab) {
        0 => const MyWishlistScreen(),
        1 => const FamilyScreen(),
        _ => const MyClaimsScreen(),
      },
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.card_giftcard),
            label: 'Ma liste',
          ),
          NavigationDestination(icon: Icon(Icons.people), label: 'Famille'),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart),
            label: 'Mes achats',
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _askNameIfMissing();
  }

  Future<void> _askNameIfMissing() async {
    final String? name;
    try {
      name = await client.profile.getName();
    } catch (_) {
      return; // Offline or server down: ask again next launch.
    }
    // The dialog appears after the `await` above, so the screen is fully
    // built by then (showing a dialog directly inside initState would fail).
    if (name == null && mounted) await _askName(canCancel: false);
  }

  Future<void> _changeName() async {
    String? current;
    try {
      current = await client.profile.getName();
    } catch (_) {}
    if (mounted) await _askName(initial: current, canCancel: true);
  }

  /// Shows the dialog until a name is saved, or it is cancelled (if allowed).
  Future<void> _askName({String? initial, required bool canCancel}) async {
    while (mounted) {
      final name = await showNameDialog(
        context,
        initial: initial,
        canCancel: canCancel,
      );
      if (name == null || !mounted) return;
      if (await runAction(context, () => client.profile.setName(name))) return;
    }
  }
}
