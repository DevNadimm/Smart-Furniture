import 'package:flutter/material.dart';
import 'package:smart_furniture/core/utils/themes/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Furniture',
      theme: theme,
      home: const Placeholder(),
    );
  }
}
