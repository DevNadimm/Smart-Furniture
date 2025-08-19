import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter {
  /// Formats a number to a currency-like format with commas.
  /// Example EN: 10000 -> 10,000
  /// Example BN: 10000 -> ১০,০০০
  static String format(num? amount, {BuildContext? context}) {
    if (amount == null) return '0';

    // default to English if no context provided
    final locale = context != null
        ? Localizations.localeOf(context).languageCode
        : 'en';

    return NumberFormat.decimalPattern(locale).format(amount);
  }

  /// Parses a formatted string back to a number.
  /// Example: "10,000" or "১০,০০০" -> 10000
  static num? parse(String? formatted) {
    if (formatted == null || formatted.isEmpty) return null;

    // Remove all non-digit characters (keeps negative and decimal)
    final cleaned = formatted.replaceAll(RegExp(r'[^0-9.-]'), '');

    return num.tryParse(cleaned);
  }
}
