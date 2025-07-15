import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/themes/app_bar_theme.dart';
import 'package:smart_furniture/core/utils/themes/elevated_button_theme.dart';
import 'package:smart_furniture/core/utils/themes/input_decoration_theme.dart';
import 'package:smart_furniture/core/utils/themes/text_theme.dart';

ThemeData theme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primaryColor,
  appBarTheme: appBarTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  inputDecorationTheme: inputDecorationTheme,
  textTheme: textTheme,
  scaffoldBackgroundColor: AppColors.backgroundColor,
);
