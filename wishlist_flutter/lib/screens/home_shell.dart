import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import 'my_wishlist_screen.dart';
import 'family_screen.dart';
import 'my_claims_screen.dart';
import '../async_ui.dart';
import 'name_dialog.dart';
import '../theme_mode.dart';

enum _MenuAction { changeName, theme, signOut }

/// The signed-in app: three tabs at the bottom, sign-out at the top.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  var _tab = 0;

  /// Bumping this rebuilds the current tab from scratch, which reloads it.
  var _refreshCount = 0;
  late final AppLifecycleListener _lifecycle;

  void _refresh() => setState(() => _refreshCount++);

  @override
  void initState() {
    super.initState();
    // Coming back to the app (other tab, phone unlocked...): other people may
    // have changed things meanwhile.
    _lifecycle = AppLifecycleListener(onResume: _refresh);
    _askNameIfMissing();
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  static const _titles = ['Mes idées', 'Famille', 'Mes achats'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_tab]),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Actualiser',
            onPressed: _refresh,
          ),
          PopupMenuButton<_MenuAction>(
            onSelected: (action) => switch (action) {
              _MenuAction.changeName => _changeName(),
              _MenuAction.theme => _pickTheme(),
              _MenuAction.signOut => client.auth.signOutDevice(),
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: _MenuAction.changeName,
                child: Text('Changer mon prénom'),
              ),
              PopupMenuItem(value: _MenuAction.theme, child: Text('Thème')),
              PopupMenuItem(
                value: _MenuAction.signOut,
                child: Text('Se déconnecter'),
              ),
            ],
          ),
        ],
      ),
      body: KeyedSubtree(
        key: ValueKey(_refreshCount),
        child: switch (_tab) {
          0 => const MyWishlistScreen(),
          1 => const FamilyScreen(),
          _ => const MyClaimsScreen(),
        },
      ),
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
    while (true) {
      if (!mounted) return;
      final name = await showNameDialog(
        context,
        initial: initial,
        canCancel: canCancel,
      );
      if (name == null || !mounted) return;
      if (await runAction(context, () => client.profile.setName(name))) return;
    }
  }

  Future<void> _pickTheme() async {
    final picked = await showDialog<ThemeMode>(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Thème'),
        children: [
          // A record (mode, label) per option, destructured in the loop.
          for (final (mode, label) in const [
            (ThemeMode.system, 'Automatique (comme le téléphone)'),
            (ThemeMode.light, 'Clair'),
            (ThemeMode.dark, 'Sombre'),
          ])
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context, mode),
              child: Row(
                children: [
                  // Icon(null) is an empty slot of the same size, so the
                  // labels stay aligned whether or not they're checked.
                  Icon(mode == themeMode.value ? Icons.check : null),
                  const SizedBox(width: 12),
                  Text(label),
                ],
              ),
            ),
        ],
      ),
    );
    if (picked != null) await saveThemeMode(picked);
  }
}
