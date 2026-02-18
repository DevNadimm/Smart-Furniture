import 'package:flutter/material.dart';

class LocalizationService {
  /// Returns localized text based on app locale
  static String getText(
    BuildContext context, {
    required String en,
    String? bn,
  }) {
    final languageCode = Localizations.localeOf(context).languageCode;

    if (languageCode == 'bn' && (bn?.isNotEmpty ?? false)) {
      return bn!;
    }

    return en;
  }
}
