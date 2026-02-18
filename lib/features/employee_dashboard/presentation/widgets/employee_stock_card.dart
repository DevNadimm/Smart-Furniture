import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/employee_stock_model.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class EmployeeStockCard extends StatelessWidget {
  final StockItem? stock;

  const EmployeeStockCard({super.key, required this.stock});

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
              padding: const EdgeInsets.all(12),
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              child: Text(
                LocalizationService.getText(context, en: stock?.productName ?? strings.notAvailable, bn: stock?.productNameBn),
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColors.primaryColor,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Category
                  Text(
                    "${strings.category}: ${LocalizationService.getText(context, en: stock?.category ?? strings.notAvailable, bn: stock?.categoryNameBn)}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  const SizedBox(height: 6),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  const SizedBox(height: 6),

                  /// Quantity & Unit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        strings.quantity,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      _infoTag(
                        "${CurrencyFormatter.format(num.tryParse(stock?.quantity ?? '0'), context: context)} ${stock?.unit ?? ''}",
                        AppColors.success,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTag(String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: color,
        ),
      ),
    );
  }
}
