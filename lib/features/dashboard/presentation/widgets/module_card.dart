import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/module.dart';

class ModuleCard extends StatelessWidget {
  final Module module;

  const ModuleCard({super.key, required this.module});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(width: 1.4, color: AppColors.borderColor),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardColor,
            blurRadius: 20,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: module.onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(module.icon, color: AppColors.primaryColor),
                ),
                const SizedBox(height: 12),
                Text(
                  module.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold,),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Text(
                  module.primaryInfo,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  module.secondaryInfo,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
