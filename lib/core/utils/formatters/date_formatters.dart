import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormatters {
  DateFormatters._();

  /// Localized date formatter based on current context locale
  static String readableDate(BuildContext context, String? date) {
    if (date == null || date.isEmpty) return "N/A";

    try {
      final parsedDate = DateTime.parse(date);
      final locale = Localizations.localeOf(context).languageCode;

      return DateFormat.yMMMMd(locale).format(parsedDate);
    } catch (e) {
      return date;
    }
  }
}
