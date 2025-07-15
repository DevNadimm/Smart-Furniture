import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';

InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  errorMaxLines: 3,
  prefixIconColor: AppColors.secondaryFontColor,
  suffixIconColor: AppColors.secondaryFontColor,
  fillColor: AppColors.cardColor,
  filled: true,
  contentPadding: const EdgeInsets.all(16),
  labelStyle: const TextStyle().copyWith(fontSize: 16, color: AppColors.secondaryFontColor),
  hintStyle: const TextStyle().copyWith(fontSize: 16, color: AppColors.secondaryFontColor, fontWeight: FontWeight.w500),
  errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
  floatingLabelStyle: const TextStyle().copyWith(
    color: Colors.black.withOpacity(0.8),
  ),
  border: const OutlineInputBorder().copyWith(
    borderRadius: BorderRadius.circular(14),
    borderSide: const BorderSide(width: 1.4, color: AppColors.inputBorderColor),
  ),
  enabledBorder: const OutlineInputBorder().copyWith(
    borderRadius: BorderRadius.circular(14),
    borderSide: const BorderSide(width: 1.4, color: AppColors.inputBorderColor),
  ),
  focusedBorder: const OutlineInputBorder().copyWith(
    borderRadius: BorderRadius.circular(14),
    borderSide: const BorderSide(width: 1.7, color: AppColors.inputBorderFocusedColor),
  ),
  errorBorder: const OutlineInputBorder().copyWith(
    borderRadius: BorderRadius.circular(14),
    borderSide: const BorderSide(width: 1.4, color: AppColors.error),
  ),
  focusedErrorBorder: const OutlineInputBorder().copyWith(
    borderRadius: BorderRadius.circular(14),
    borderSide: const BorderSide(width: 1.7, color: AppColors.warning),
  ),
);