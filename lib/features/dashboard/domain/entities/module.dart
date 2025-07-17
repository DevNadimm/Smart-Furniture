import 'package:flutter/material.dart';

class Module {
  final String title;
  final String iconPath;
  final String primaryInfo;
  final String secondaryInfo;
  final VoidCallback onTap;

  Module({
    required this.title,
    required this.iconPath,
    required this.primaryInfo,
    required this.secondaryInfo,
    required this.onTap,
  });
}
