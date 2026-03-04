import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/features/company/data/models/fixed_production_model.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class FixedProductionCard extends StatelessWidget {
  final FixedProductionData? production;

  const FixedProductionCard({
    super.key,
    required this.production,
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
          ),
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
                        LocalizationService.getText(
                          context,
                          en: production?.productName ?? strings.notAvailable,
                          bn: production?.productNameBn,
                        ),
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: AppColors.primaryColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  if (production?.bomNumber != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        production!.bomNumber!,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: AppColors.primaryColor),
                      ),
                    ),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Recipe Number & Version
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoRow(
                          context,
                          icon: HugeIcons.strokeRoundedFile02,
                          label: strings.recipeNumber,
                          value: production?.recipeNumber ??
                              strings.notAvailable,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInfoRow(
                          context,
                          icon: HugeIcons.strokeRoundedGitBranch,
                          label: strings.recipeVersion,
                          value: production?.recipeVersion ??
                              strings.notAvailable,
                        ),
                      ),
                    ],
                  ),

                  const Divider(color: AppColors.borderColor, thickness: 1),
                  const SizedBox(height: 6),

                  /// Quantity & Unit
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoRow(
                          context,
                          icon: HugeIcons.strokeRoundedPackage,
                          label: strings.quantity,
                          value: CurrencyFormatter.format(
                            production?.quantity,
                            context: context,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInfoRow(
                          context,
                          icon: HugeIcons.strokeRoundedCells,
                          label: strings.unit,
                          value: production?.productUnit ??
                              strings.notAvailable,
                        ),
                      ),
                    ],
                  ),

                  /// Materials Count & Total Material Cost
                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoRow(
                          context,
                          icon: HugeIcons.strokeRoundedLayer,
                          label: strings.materialsCount,
                          value: CurrencyFormatter.format(
                            production?.materialsCount,
                            context: context,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildInfoRow(
                          context,
                          icon: HugeIcons.strokeRoundedMoney01,
                          label: strings.totalMaterialCost,
                          value:
                          '৳${CurrencyFormatter.format(production?.totalMaterialCost, context: context)}',
                          valueColor: AppColors.error,
                        ),
                      ),
                    ],
                  ),

                  /// Date
                  _buildInfoRow(
                    context,
                    icon: HugeIcons.strokeRoundedCalendar03,
                    label: strings.date,
                    value: DateFormatters.readableDate(
                        context, production?.createdAt),
                  ),
                ],
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
        Color? valueColor,
        int maxLines = 1,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HugeIcon(icon: icon, color: AppColors.primaryColor, size: 18),
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
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: valueColor,
                  ),
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