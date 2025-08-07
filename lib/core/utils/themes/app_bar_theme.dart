import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';

AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: AppColors.backgroundColor,
  foregroundColor: AppColors.primaryFontColor,
  scrolledUnderElevation: 0,
  elevation: 0,
  centerTitle: false,
  titleTextStyle: GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryFontColor,
    height: 1.3,
  )
);
