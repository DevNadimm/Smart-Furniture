import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';

class UserRoleCard extends StatelessWidget {
  final String roleName;
  final String roleCode;
  final String imageName;
  final String selectedCode;
  final VoidCallback onTap;

  const UserRoleCard({
    super.key,
    required this.roleName,
    required this.roleCode,
    required this.imageName,
    required this.selectedCode,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = selectedCode == roleCode;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            width: 1.4,
            color: isSelected ? AppColors.primaryColor : AppColors.borderColor,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: CircleAvatar(
                radius: 10,
                backgroundImage: AssetImage(imageName),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              roleName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            Icon(
              isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: isSelected ? AppColors.primaryColor : AppColors.borderColor,
            )
          ],
        ),
      ),
    );
  }
}
