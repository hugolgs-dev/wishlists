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

class FamilyItemTile extends StatelessWidget {
  const FamilyItemTile({
    super.key,
    required this.item,
    this.trailing,
    this.showOwner = false,
  });

  final FamilyItem item;
  final Widget? trailing;

  /// True on the shopping list, where items from several people are mixed.
  final bool showOwner;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final url = item.url;
    final details = [
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
      leading: Text('★' * (4 - item.priority)),
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
            Text(
              'Changed since you claimed it',
              style: TextStyle(color: colors.tertiary),
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
