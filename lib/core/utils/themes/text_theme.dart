import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

final TextTheme textTheme = TextTheme(
  displayLarge: GoogleFonts.poppins(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: AppColors.primaryFontColor,
    height: 1.3,
    letterSpacing: 0.25,
  ),
  displayMedium: GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryFontColor,
    height: 1.3,
  ),
  displaySmall: GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryFontColor,
    height: 1.3,
  ),
  headlineLarge: GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryFontColor,
    height: 1.3,
  ),
  headlineMedium: GoogleFonts.poppins(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.primaryFontColor,
    height: 1.3,
  ),
  headlineSmall: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryFontColor,
    height: 1.4,
  ),
  titleLarge: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.secondaryFontColor,
    height: 1.4,
  ),
  titleMedium: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.secondaryFontColor,
    height: 1.4,
  ),
  bodyLarge: GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryFontColor,
    height: 1.5,
  ),
  bodyMedium: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.primaryFontColor,
    height: 1.5,
  ),
  bodySmall: GoogleFonts.poppins(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.lightFontColor,
    height: 1.3,
  ),
  labelLarge: GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.buttonFontColor,
    letterSpacing: 1.25,
    height: 1.3,
  ),
  labelSmall: GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.lightFontColor,
    letterSpacing: 1.5,
    height: 1.3,
  ),
);
