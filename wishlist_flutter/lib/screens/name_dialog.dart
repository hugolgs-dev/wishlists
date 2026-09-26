import 'package:flutter/material.dart';

/// Asks for a first name. Returns it trimmed, or null if cancelled.
/// With [canCancel] false (first sign-in), the dialog cannot be dismissed.
Future<String?> showNameDialog(
  BuildContext context, {
  String? initial,
  bool canCancel = true,
}) => showDialog<String>(
  context: context,
  barrierDismissible: canCancel, // tap outside to close
  builder: (_) => _NameDialog(initial: initial, canCancel: canCancel),
);

class _NameDialog extends StatefulWidget {
  const _NameDialog({this.initial, required this.canCancel});

  final String? initial;
  final bool canCancel;

  @override
  State<_NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<_NameDialog> {
  final _formKey = GlobalKey<FormState>();
  late final _controller = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.pop(context, _controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    // PopScope blocks the Android back button when cancelling isn't allowed.
    return PopScope(
      canPop: widget.canCancel,
      child: AlertDialog(
        title: const Text('Votre prénom'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _controller,
            autofocus: true,
            maxLength: 30, // same limit as the server
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              helperText: 'Visible par toute la famille',
            ),
            validator: (v) => v!.trim().isEmpty ? 'Obligatoire' : null,
            onFieldSubmitted: (_) => _save(),
          ),
        ),
        actions: [
          if (widget.canCancel)
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
          FilledButton(onPressed: _save, child: const Text('Enregistrer')),
        ],
      ),
    );
  }
}
