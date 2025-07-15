import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';

class CustomSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const CustomSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.inputBorderColor,
          width: 1.4,
        ),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: Text(
          title,
          style: const TextStyle().copyWith(fontSize: 16, color: AppColors.secondaryFontColor, fontWeight: FontWeight.w500),
        ),
        activeColor: AppColors.inputBorderFocusedColor,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
