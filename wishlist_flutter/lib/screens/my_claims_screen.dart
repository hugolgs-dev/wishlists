import 'package:flutter/material.dart';
import 'package:wishlist_client/wishlist_client.dart';

import '../async_ui.dart';
import '../client.dart';
import 'family_item_tile.dart';

/// Everything the caller reserved, across all lists: their shopping list.
class MyClaimsScreen extends StatefulWidget {
  const MyClaimsScreen({super.key});

  @override
  State<MyClaimsScreen> createState() => _MyClaimsScreenState();
}

class _MyClaimsScreenState extends State<MyClaimsScreen> {
  late Future<List<FamilyItem>> _items = _load();

  /// Sorted by person, then title, so each person's gifts are together.
  Future<List<FamilyItem>> _load() async {
    final items = await client.claims.mine();
    return items..sort(
      (a, b) => a.ownerName != b.ownerName
          ? a.ownerName.compareTo(b.ownerName)
          : a.title.compareTo(b.title),
    );
  }

  void _reload() => setState(() => _items = _load());

  Future<void> _setPurchased(FamilyItem item, bool purchased) async {
    if (await runAction(
          context,
          () => client.claims.setPurchased(item.id, purchased),
        ) &&
        mounted) {
      _reload();
    }
  }

  Future<void> _unclaim(FamilyItem item) async {
    if (await runAction(
          context,
          () => client.claims.unclaim(item.id),
          success: 'Réservation retirée',
        ) &&
        mounted) {
      _reload();
    }
  }

  Future<void> _markSeen(FamilyItem item) async {
    if (await runAction(context, () => client.claims.markSeen(item.id)) &&
        mounted) {
      _reload();
    }
  }

  Widget _action(FamilyItem item) {
    // Deleted by its owner: nothing to buy, just let the user clear it.
    if (item.removed) {
      return OutlinedButton(
        onPressed: () => _unclaim(item),
        child: const Text('Retirer'),
      );
    }
    return Checkbox(
      value: item.myPurchased,
      semanticLabel: 'Acheté',
      onChanged: (value) => _setPurchased(item, value ?? false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AsyncList(
      future: _items,
      onRetry: _reload,
      emptyText:
          "Vous n'avez rien réservé pour l'instant.\n"
          'Allez voir les listes dans « Famille ».',
      itemBuilder: (item) => FamilyItemTile(
        item: item,
        showOwner: true, // "Pour Maman · 19,99 €"
        trailing: _action(item),
        onSeen: () => _markSeen(item),
      ),
    );
  }
}
