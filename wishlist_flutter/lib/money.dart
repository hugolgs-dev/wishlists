/// 1999 -> "19.99 €"
String formatPrice(int cents) =>
    '${(cents / 100).toStringAsFixed(2).replaceAll('.', ',')} €';

/// "19.99" or "19,99" -> 1999. Returns null if not a valid price.
int? parsePrice(String text) {
  final value = double.tryParse(text.trim().replaceAll(',', '.'));
  if (value == null || value < 0) return null;
  return (value * 100).round();
}
