import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wishlist_client/wishlist_client.dart';
import 'package:url_launcher/url_launcher.dart';
import '../client.dart';
import '../money.dart';
import '../async_ui.dart';
import 'family_item_tile.dart'; // ItemLeading
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

  void _reload() => setState(() {
    _items = client.myWishlist.list();
  });

  Future<void> _add() async {
    final result = await showItemForm(context);
    if (result == null || !mounted) return;
    final hasImage = result.newImage != null;

    WishItem? saved;
    final added = await runAction(
      context,
      () async => saved = await client.myWishlist.add(result.item),
      // With a photo, wait for step 2 to confirm everything at once.
      success: hasImage ? null : 'Cadeau ajouté',
    );
    if (!added || !mounted) return;

    if (hasImage) {
      await runAction(
        context,
        () => _saveImage(saved!.id!, result),
        success: 'Cadeau ajouté avec sa photo',
        failure: "Cadeau ajouté, mais la photo n'a pas pu être envoyée",
      );
    }
    if (mounted) _reload(); // the item exists either way
  }

  Future<void> _edit(WishItem existing) async {
    final result = await showItemForm(context, existing: existing);
    if (result == null || !mounted) return;
    final imageChange = result.newImage != null
        ? 'photo ajoutée'
        : result.removeImage
        ? 'photo retirée'
        : null;

    final updated = await runAction(
      context,
      () => client.myWishlist.update(result.item),
      success: imageChange == null ? 'Cadeau modifié' : null,
    );
    if (!updated || !mounted) return;

    if (imageChange != null) {
      await runAction(
        context,
        () => _saveImage(existing.id!, result),
        success: 'Cadeau modifié, $imageChange',
        failure: "Cadeau modifié, mais la photo n'a pas pu être mise à jour",
      );
    }
    if (mounted) _reload();
  }

  /// Uploads or removes the picture chosen in the form. Runs after the item
  /// is saved, because a new item needs its id for the upload.
  Future<void> _saveImage(int itemId, ItemFormResult result) async {
    final bytes = result.newImage;
    if (bytes != null) {
      final upload = await client.myWishlist.imageUpload(itemId);
      final ok = await FileUploader(
        upload.description,
      ).uploadByteData(ByteData.sublistView(bytes));
      if (!ok) throw Exception('Upload failed'); // generic error snackbar
      await client.myWishlist.attachImage(itemId, upload.path);
    } else if (result.removeImage) {
      await client.myWishlist.removeImage(itemId);
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
    if (await runAction(
          context,
          () => client.myWishlist.remove(item.id!),
          success: 'Cadeau supprimé',
        ) &&
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
          leading: ItemLeading(
            imageUrl: item.imageUrl,
            priority: item.priority,
          ),
          title: Text(item.title),
          subtitle: _details(item),
          onTap: () => _edit(item),
          trailing: Row(
            mainAxisSize: MainAxisSize.min, // take only the buttons' width
            children: [
              if (item.url != null)
                IconButton(
                  icon: const Icon(Icons.open_in_new),
                  tooltip: 'Ouvrir le lien',
                  onPressed: () => launchUrl(Uri.parse(item.url!)),
                ),
              IconButton(
                icon: const Icon(Icons.delete_outline),
                tooltip: 'Supprimer',
                onPressed: () => _remove(item),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// "19.99 € · ×2 · size M", or null when there is nothing to show.
  Widget? _details(WishItem item) {
    final parts = [
      // With a picture, the stars leave the leading slot: show them here.
      if (item.imageUrl != null) '★' * (4 - item.priority),
      if (item.priceCents != null) formatPrice(item.priceCents!),
      if (item.quantity > 1) '×${item.quantity}',
      if (item.notes != null) item.notes!,
    ];
    return parts.isEmpty ? null : Text(parts.join(' · '));
  }
}
