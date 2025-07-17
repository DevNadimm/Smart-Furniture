import 'package:flutter/material.dart';

class Module {
  final String title;
  final IconData icon;
  final String primaryInfo;
  final String secondaryInfo;
  final VoidCallback onTap;

  Module({
    required this.title,
    required this.icon,
    required this.primaryInfo,
    required this.secondaryInfo,
    required this.onTap,
  });
}
