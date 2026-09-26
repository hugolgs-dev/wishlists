import 'package:flutter/material.dart';
import 'package:wishlist_client/wishlist_client.dart';

import '../money.dart';

/// Opens the add/edit form. Returns the filled item, or null if cancelled.
/// Pass [existing] to edit: the result keeps its id.
Future<WishItem?> showItemForm(BuildContext context, {WishItem? existing}) =>
    showDialog<WishItem>(
      context: context,
      builder: (_) => _ItemFormDialog(existing: existing),
    );

class _ItemFormDialog extends StatefulWidget {
  const _ItemFormDialog({this.existing});

  final WishItem? existing;

  @override
  State<_ItemFormDialog> createState() => _ItemFormDialogState();
}

class _ItemFormDialogState extends State<_ItemFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _title = TextEditingController(text: widget.existing?.title);
  late final _url = TextEditingController(text: widget.existing?.url);
  late final _notes = TextEditingController(text: widget.existing?.notes);
  late final _price = TextEditingController(
    text: switch (widget.existing?.priceCents) {
      null => '',
      final cents => (cents / 100).toStringAsFixed(2),
    },
  );
  late final _quantity = TextEditingController(
    text: '${widget.existing?.quantity ?? 1}',
  );
  late var _priority = widget.existing?.priority ?? 2;

  @override
  void dispose() {
    // Controllers hold resources: always dispose them with the widget.
    for (final c in [_title, _url, _notes, _price, _quantity]) {
      c.dispose();
    }
    super.dispose();
  }

  void _save() {
    // Runs every `validator` below; stops if one returns an error message.
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(
      context,
      WishItem(
        id: widget.existing?.id,
        title: _title.text.trim(),
        url: _emptyToNull(_url.text),
        notes: _emptyToNull(_notes.text),
        priceCents: parsePrice(_price.text),
        priority: _priority,
        quantity: int.parse(_quantity.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // These validators give friendly messages. The server checks the same
    // rules again: the client can always be bypassed.
    return AlertDialog(
      title: Text(
        widget.existing == null ? 'Nouveau cadeau' : 'Éditer le cadeau',
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _title,
                autofocus: true,
                decoration: const InputDecoration(labelText: 'Le cadeau :'),
                validator: (v) => v!.trim().isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _url,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Lien (optionel)',
                ),
                validator: (v) =>
                    v!.trim().isEmpty ||
                        v.trim().startsWith(RegExp(r'https?://'))
                    ? null
                    : 'Un lien doit commencer avec "https://"',
              ),
              TextFormField(
                controller: _price,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Prix estimmé en € (optionel)',
                ),
                validator: (v) => v!.trim().isEmpty || parsePrice(v) != null
                    ? null
                    : 'Entrer un prix (e.g 19.99)',
              ),
              TextFormField(
                controller: _quantity,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Quantité'),
                validator: (v) =>
                    (int.tryParse(v!) ?? 0) >= 1 ? null : 'Au moins 1',
              ),
              TextFormField(
                controller: _notes,
                minLines: 1,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Notes (taille, couleur(s), etc…)',
                ),
              ),
              const SizedBox(height: 16),
              SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 1, label: Text('Élevée')),
                  ButtonSegment(value: 2, label: Text('Moyenne')),
                  ButtonSegment(value: 3, label: Text('Basse')),
                ],
                selected: {_priority},
                onSelectionChanged: (s) => setState(() => _priority = s.first),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Annuler'),
        ),
        FilledButton(onPressed: _save, child: const Text('Sauvegarder')),
      ],
    );
  }
}

String? _emptyToNull(String text) => text.trim().isEmpty ? null : text.trim();
