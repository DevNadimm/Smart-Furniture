import 'package:flutter/material.dart';

class HelperFunctions {
  static String cleanErrorMessage(String error) {
    const prefix = 'Exception: ';
    if (error.startsWith(prefix)) {
      return error.substring(prefix.length);
    }
    return error;
  }

  static String localeShopName(BuildContext context, String branchName) {
    final locale = Localizations.localeOf(context);

    if (locale.languageCode != 'bn') {
      return branchName;
    }

    const Map<String, String> bnNames = {
      "SMART FURNITURE": "স্মার্ট ফার্নিচার",
      "NAIM FURNITURE": "নাঈম ফার্নিচার",
      "NOORJAHAN FURNITURE": "নূরজাহান ফার্নিচার",
      "NOORJAHAN STEEL": "নূরজাহান স্টিল",
    };

    return bnNames[branchName] ?? branchName;
  }
}
