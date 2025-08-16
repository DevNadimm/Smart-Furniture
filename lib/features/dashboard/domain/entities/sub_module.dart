import 'package:flutter/material.dart';

class SubModule {
  final String title;
  final String subTitle;
  final String iconPath;
  final VoidCallback onTap;

  SubModule({
    required this.title,
    required this.subTitle,
    required this.iconPath,
    required this.onTap,
  });
}
