import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';

class AppBarSearchField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSubmitted;
  final String hintText;

  const AppBarSearchField({
    super.key,
    required this.controller,
    required this.onSubmitted,
    this.hintText = 'Search...',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        autofocus: true,
        cursorColor: AppColors.primaryColor,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: Theme.of(context)
              .inputDecorationTheme
              .hintStyle
              ?.copyWith(fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        ),
        textInputAction: TextInputAction.search,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
