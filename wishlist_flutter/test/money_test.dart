import 'package:flutter_test/flutter_test.dart';
import 'package:wishlist_flutter/money.dart';

void main() {
  test('parsePrice accepts dot and comma, rejects junk', () {
    expect(parsePrice('19.99'), 1999);
    expect(parsePrice('19,99'), 1999);
    expect(parsePrice(' 5 '), 500);
    expect(parsePrice('abc'), isNull);
    expect(parsePrice('-1'), isNull);
  });

  test('formatPrice shows two decimals', () {
    expect(formatPrice(1999), '19,99 €');
    expect(formatPrice(500), '5,00 €');
  });
}
