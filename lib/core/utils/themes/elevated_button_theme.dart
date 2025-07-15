import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';

ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.primaryColor,
    foregroundColor: AppColors.buttonFontColor,
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    textStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
  ),
);
