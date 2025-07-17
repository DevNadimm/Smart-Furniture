import 'package:flutter/material.dart';
import 'package:smart_furniture/core/utils/themes/theme.dart';
import 'package:smart_furniture/features/language_selector/presentation/pages/language_selection_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Furniture',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const LanguageSelectionPage(),
    );
  }
}
