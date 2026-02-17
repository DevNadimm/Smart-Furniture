import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/features/admin/data/models/supplier_model.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class SupplierCard extends StatelessWidget {
  final SupplierData supplier;
  final VoidCallback? onTap;

  const SupplierCard({
    super.key,
    required this.supplier,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            /// Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        supplier.name ?? strings.notAvailable,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Body
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (supplier.nameBn != null && supplier.nameBn!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            supplier.nameBn!,
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey.withValues(alpha: 0.8),
                            ),
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    const Divider(color: AppColors.borderColor, thickness: 1),
                    const SizedBox(height: 6),

                    /// Phone
                    if (supplier.phone != null && supplier.phone!.isNotEmpty)
                      _buildInfoRow(
                        context,
                        icon: HugeIcons.strokeRoundedCall,
                        label: strings.phone,
                        value: supplier.phone!,
                      ),

                    /// Email
                    if (supplier.email != null && supplier.email!.isNotEmpty)
                      _buildInfoRow(
                        context,
                        icon: HugeIcons.strokeRoundedMail01,
                        label: strings.email,
                        value: supplier.email!,
                      ),

                    /// Address
                    if (supplier.address != null && supplier.address!.isNotEmpty)
                      _buildInfoRow(
                        context,
                        icon: HugeIcons.strokeRoundedLocation01,
                        label: strings.address,
                        value: supplier.address!,
                        maxLines: 2,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        int maxLines = 1,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HugeIcon(
            icon: icon,
            color: AppColors.primaryColor,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}