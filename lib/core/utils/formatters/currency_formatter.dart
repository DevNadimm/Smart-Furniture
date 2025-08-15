import 'package:intl/intl.dart';

class CurrencyFormatter {
  /// Formats a number to a currency-like format with commas.
  /// Example: 10000 -> 10,000
  static String format(num? amount) {
    if (amount == null) return '';
    return NumberFormat('#,##0.##').format(amount);
  }

  /// Parses a formatted string back to a number.
  /// Example: "10,000" -> 10000
  static num? parse(String? formatted) {
    if (formatted == null || formatted.isEmpty) return null;
    final cleaned = formatted.replaceAll(RegExp(r'[^0-9.-]'), '');
    return num.tryParse(cleaned);
  }
}
