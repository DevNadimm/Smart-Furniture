import 'package:flutter/material.dart';

class Module {
  final String title;
  final String iconPath;
  final String subTitle;
  final VoidCallback onTap;

  Module({
    required this.title,
    required this.iconPath,
    required this.subTitle,
    required this.onTap,
  });
}
