import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wishlist_flutter/async_ui.dart';

/// Fake "server" data the screen below loads.
var _serverData = ['A'];

/// Same reload pattern as the real screens (my_wishlist_screen.dart...).
class _Screen extends StatefulWidget {
  const _Screen();

  @override
  State<_Screen> createState() => _ScreenState();
}

class _ScreenState extends State<_Screen> {
  late Future<List<String>> _items = _load();

  Future<List<String>> _load() async => List.of(_serverData);

  // Braces matter: `setState(() => _items = ...)` returns the Future, which
  // Flutter rejects in debug mode, and the list never redraws.
  void _reload() => setState(() {
    _items = _load();
  });

  @override
  Widget build(BuildContext context) => AsyncList<String>(
    future: _items,
    onRetry: _reload,
    emptyText: 'vide',
    itemBuilder: Text.new,
  );
}

void main() {
  testWidgets('requestRefresh redraws the list with new data', (tester) async {
    _serverData = ['A'];
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: _Screen())));
    await tester.pumpAndSettle();
    expect(find.text('B'), findsNothing);

    _serverData = ['A', 'B'];
    requestRefresh();
    await tester.pumpAndSettle();

    expect(find.text('B'), findsOneWidget);
  });
}
