import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import '../client.dart';
import 'my_wishlist_screen.dart';
import 'family_screen.dart';
import 'my_claims_screen.dart';

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
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Se déconnecter',
            // SignInScreen listens to auth changes and shows the sign-in form.
            onPressed: () => client.auth.signOutDevice(),
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
}
