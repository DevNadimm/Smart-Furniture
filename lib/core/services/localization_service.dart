import 'package:flutter/material.dart';

class LocalizationService {
  /// Returns localized string based on current locale
  static String getText(
    BuildContext context, {
    required String en,
    required String bn,
  }) {
    final locale = Localizations.localeOf(context).languageCode;

    if (locale == 'bn') {
      return bn;
    }
    return en;
  }
}
