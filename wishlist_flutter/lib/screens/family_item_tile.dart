import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wishlist_client/wishlist_client.dart';

import '../money.dart';

extension FamilyItemCounts on FamilyItem {
  /// Units claimed by other people.
  int get claimedByOthers =>
      claims.fold(0, (sum, c) => sum + c.quantity) - myQuantity;

  /// Units the caller may claim (their own share included). Same rule as the
  /// server: others + mine <= quantity.
  int get available => quantity - claimedByOthers;
}

/// The item's picture if it has one, otherwise the priority stars.
/// Tapping the picture shows it full-screen.
class ItemLeading extends StatelessWidget {
  const ItemLeading({
    super.key,
    required this.imageUrl,
    required this.priority,
  });

  final String? imageUrl;
  final int priority;

  @override
  Widget build(BuildContext context) {
    final stars = Text('★' * (4 - priority));
    final url = imageUrl;
    if (url == null) return stars;
    return Semantics(
      label: 'Agrandir la photo', // read by screen readers
      button: true,
      // GestureDetector catches the tap before the ListTile does.
      child: GestureDetector(
        onTap: () => showImageViewer(context, url),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            url,
            width: 56,
            height: 56,
            fit: BoxFit.cover, // fill the square, cropping if needed
            // Broken link or offline: fall back to the stars.
            errorBuilder: (_, _, _) => stars,
          ),
        ),
      ),
    );
  }
}

/// The picture on a black full-screen page. Pinch or double-tap to zoom.
void showImageViewer(BuildContext context, String url) {
  Navigator.push(
    context,
    MaterialPageRoute(
      fullscreenDialog: true, // slides up, with a ✕ instead of a back arrow
      builder: (_) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: InteractiveViewer(maxScale: 4, child: Image.network(url)),
        ),
      ),
    ),
  );
}

class FamilyItemTile extends StatelessWidget {
  const FamilyItemTile({
    super.key,
    required this.item,
    this.trailing,
    this.showOwner = false,
    this.onSeen,
  });

  final FamilyItem item;
  final Widget? trailing;

  /// True on the shopping list, where items from several people are mixed.
  final bool showOwner;
  final VoidCallback? onSeen;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final url = item.url;
    final details = [
      // With a picture, the stars leave the leading slot: show them here.
      if (item.imageUrl != null) '★' * (4 - item.priority),
      if (showOwner) 'For ${item.ownerName}',
      if (item.priceCents != null) formatPrice(item.priceCents!),
      if (item.quantity > 1) '×${item.quantity}',
      if (item.notes != null) item.notes!,
    ].join(' · ');
    final claimedBy = [
      for (final c in item.claims)
        c.quantity > 1 ? '${c.claimerName} (×${c.quantity})' : c.claimerName,
    ].join(', ');

    return ListTile(
      leading: ItemLeading(imageUrl: item.imageUrl, priority: item.priority),
      title: Text(
        item.title,
        style: item.removed
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (details.isNotEmpty) Text(details),
          if (claimedBy.isNotEmpty) Text('Claimed by $claimedBy'),
          if (url != null)
            Text('Tap to open link', style: TextStyle(color: colors.primary)),
          if (item.removed)
            Text('Removed by owner', style: TextStyle(color: colors.error)),
          if (!item.removed && item.changedSinceMyClaim)
            Row(
              children: [
                Flexible(
                  child: Text(
                    'Modifié depuis votre réservation',
                    style: TextStyle(color: colors.tertiary),
                  ),
                ),
                if (onSeen != null)
                  TextButton(onPressed: onSeen, child: const Text('Vu')),
              ],
            ),
        ],
      ),
      // The server only accepts http(s) links, so this cannot open
      // `javascript:` or local files.
      onTap: url == null ? null : () => launchUrl(Uri.parse(url)),
      trailing: trailing,
    );
  }
}
