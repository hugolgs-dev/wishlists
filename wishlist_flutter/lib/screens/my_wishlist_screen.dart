import 'package:flutter/material.dart';
import 'package:wishlist_client/wishlist_client.dart';

import '../client.dart';
import '../money.dart';
import '../async_ui.dart';
import 'item_form_dialog.dart';

/// The signed-in user's own list. No claim info here, by design: the server
/// only ever sends WishItem to the owner.
class MyWishlistScreen extends StatefulWidget {
  const MyWishlistScreen({super.key});

  @override
  State<MyWishlistScreen> createState() => _MyWishlistScreenState();
}

class _MyWishlistScreenState extends State<MyWishlistScreen> {
  // The pending server call. FutureBuilder below shows a spinner while it
  // runs, then the list or an error. Reloading = replacing this future.
  late Future<List<WishItem>> _items = client.myWishlist.list();

  void _reload() => setState(() => _items = client.myWishlist.list());

  Future<void> _add() async {
    final item = await showItemForm(context);
    if (item == null || !mounted) return;
    if (await runAction(context, () => client.myWishlist.add(item)) &&
        mounted) {
      _reload();
    }
  }

  Future<void> _edit(WishItem existing) async {
    final item = await showItemForm(context, existing: existing);
    if (item == null || !mounted) return;
    if (await runAction(context, () => client.myWishlist.update(item)) &&
        mounted) {
      _reload();
    }
  }

  Future<void> _remove(WishItem item) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Supprimer "${item.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    if (await runAction(context, () => client.myWishlist.remove(item.id!)) &&
        mounted) {
      _reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _add,
        icon: const Icon(Icons.add),
        label: const Text('Ajouter un cadeau'),
      ),
      body: AsyncList(
        future: _items,
        onRetry: _reload,
        emptyText: 'Liste vide, ajoutez un cadeau!',
        itemBuilder: (item) => ListTile(
          leading: Text('★' * (4 - item.priority)), // 1 = ★★★
          title: Text(item.title),
          subtitle: _details(item),
          onTap: () => _edit(item),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Remove',
            onPressed: () => _remove(item),
          ),
        ),
      ),
    );
  }

  /// "19.99 € · ×2 · size M", or null when there is nothing to show.
  Widget? _details(WishItem item) {
    final parts = [
      if (item.priceCents != null) formatPrice(item.priceCents!),
      if (item.quantity > 1) '×${item.quantity}',
      if (item.notes != null) item.notes!,
    ];
    return parts.isEmpty ? null : Text(parts.join(' · '));
  }
}
