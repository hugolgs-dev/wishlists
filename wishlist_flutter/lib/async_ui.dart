import 'package:flutter/material.dart';
import 'package:wishlist_client/wishlist_client.dart';

/// Bumped to make every visible list reload (refresh button, app resume).
///
/// Lists reload IN PLACE: screens are never rebuilt from scratch, so a dialog
/// that is open at that moment (e.g. the item form while picking a photo)
/// can still hand its result back to its screen.
final refreshSignal = ValueNotifier(0);

void requestRefresh() => refreshSignal.value++;

/// Shows a spinner, an error with retry, an empty message, or the list.
/// Pull down to refresh. Also reloads on [requestRefresh].
class AsyncList<T> extends StatefulWidget {
  const AsyncList({
    super.key,
    required this.future,
    required this.onRetry,
    required this.emptyText,
    required this.itemBuilder,
  });

  final Future<List<T>> future;
  final VoidCallback onRetry;
  final String emptyText;
  final Widget Function(T item) itemBuilder;

  @override
  State<AsyncList<T>> createState() => _AsyncListState<T>();
}

class _AsyncListState<T> extends State<AsyncList<T>> {
  @override
  void initState() {
    super.initState();
    refreshSignal.addListener(_onRefresh);
  }

  @override
  void dispose() {
    refreshSignal.removeListener(_onRefresh); // no calls once the list is gone
    super.dispose();
  }

  // Asks the screen to reload. FutureBuilder keeps showing the previous data
  // meanwhile: no spinner flash, and the scroll position stays.
  void _onRefresh() => widget.onRetry();

  @override
  Widget build(BuildContext context) {
    final onRetry = widget.onRetry;
    final emptyText = widget.emptyText;
    final itemBuilder = widget.itemBuilder;
    return FutureBuilder<List<T>>(
      future: widget.future,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: TextButton(
              onPressed: onRetry,
              child: const Text(
                'Chargement impossible, cliquer/taper pour réessayer',
              ),
            ),
          );
        }
        // While reloading, FutureBuilder keeps the previous data, so the
        // list stays visible instead of flashing a spinner.
        final items = snapshot.data;
        if (items == null) {
          return const Center(child: CircularProgressIndicator());
        }
        if (items.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(emptyText, textAlign: TextAlign.center),
            ),
          );
        }
        return RefreshIndicator(
          onRefresh: () async => onRetry(),
          child: ListView(
            padding: const EdgeInsets.only(bottom: 88), // room for a FAB
            children: [for (final item in items) itemBuilder(item)],
          ),
        );
      },
    );
  }
}

/// Runs a server call. On failure shows the WishlistException message, or a
/// generic one for anything else. Returns true on success.
Future<bool> runAction(
  BuildContext context,
  Future<void> Function() action,
) async {
  // Grab the messenger BEFORE the await: after it, `context` may belong to
  // a screen that was closed in the meantime.
  final messenger = ScaffoldMessenger.of(context);
  try {
    await action();
    return true;
  } on WishlistException catch (e) {
    messenger.showSnackBar(SnackBar(content: Text(e.message)));
  } catch (_) {
    messenger.showSnackBar(
      const SnackBar(content: Text('Une erreur est survenue, réessayez')),
    );
  }
  return false;
}
