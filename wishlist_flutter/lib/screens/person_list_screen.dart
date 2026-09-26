import 'package:flutter/material.dart';
import 'package:wishlist_client/wishlist_client.dart';

import '../async_ui.dart';
import '../client.dart';
import 'family_item_tile.dart';

class PersonListScreen extends StatefulWidget {
  const PersonListScreen({super.key, required this.member});

  final Member member;

  @override
  State<PersonListScreen> createState() => _PersonListScreenState();
}

class _PersonListScreenState extends State<PersonListScreen> {
  late Future<List<FamilyItem>> _items = _load();

  Future<List<FamilyItem>> _load() => client.family.list(widget.member.userId);

  void _reload() => setState(() => _items = _load());

  Future<void> _claim(FamilyItem item) async {
    // Only ask "how many?" when there is a choice.
    final quantity = item.available <= 1
        ? 1
        : await _askQuantity(item.available);
    if (quantity == null || !mounted) return;
    if (await runAction(
          context,
          () => client.claims.claim(item.id, quantity),
        ) &&
        mounted) {
      _reload();
    }
  }

  Future<void> _unclaim(FamilyItem item) async {
    if (await runAction(context, () => client.claims.unclaim(item.id)) &&
        mounted) {
      _reload();
    }
  }

  Future<int?> _askQuantity(int max) => showDialog<int>(
    context: context,
    builder: (context) => SimpleDialog(
      title: const Text('Combien en prenez-vous ?'),
      children: [
        for (var n = 1; n <= max; n++)
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, n),
            child: Text('$n'),
          ),
      ],
    ),
  );

  Widget _action(FamilyItem item) {
    if (item.myQuantity > 0) {
      return OutlinedButton(
        onPressed: () => _unclaim(item),
        child: const Text('Annuler'),
      );
    }
    if (item.available <= 0) return const Text('Déjà réservé');
    return FilledButton(
      onPressed: () => _claim(item),
      child: const Text('Réserver'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Liste de ${widget.member.name}')),
      body: AsyncList(
        future: _items,
        onRetry: _reload,
        emptyText: "${widget.member.name} n'a encore rien ajouté.",
        itemBuilder: (item) =>
            FamilyItemTile(item: item, trailing: _action(item)),
      ),
    );
  }
}
