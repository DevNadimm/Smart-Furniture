import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
        strokeWidth: 5,
      ),
    );
  }
}
