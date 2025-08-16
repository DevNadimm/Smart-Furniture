import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/sub_module.dart';

class SubModuleTile extends StatelessWidget {
  final SubModule module;

  const SubModuleTile({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Image.asset(
          module.iconPath,
          color: AppColors.primaryColor,
          scale: 6,
        ),
      ),
      title: Text(
        module.title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: Text(
        module.subTitle,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          width: 1.4,
          color: AppColors.borderColor,
        ),
      ),
      onTap: module.onTap,
    );
  }
}
