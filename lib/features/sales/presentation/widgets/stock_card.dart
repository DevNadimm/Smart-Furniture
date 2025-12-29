import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/features/sales/data/models/stock_model.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class StockCard extends StatelessWidget {
  final StockData? stockData;

  const StockCard({super.key, required this.stockData});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final brandName = stockData?.brandName ?? "N/A";
    final brandNameBn = stockData?.brandNameBangla ?? "N/A";
    final productName = stockData?.productName ?? "N/A";
    final productNameBn = stockData?.productNameBangla ?? "N/A";
    final categoryName = stockData?.categoryName ?? 'N/A';
    final categoryNameBn = stockData?.categoryNameBangla ?? 'N/A';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: AppColors.primaryColor.withOpacity(0.1),
              child: Text(
                "${strings.brand}: ${LocalizationService.getText(context, en: brandName, bn: brandNameBn)}",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    "${strings.product}: ${LocalizationService.getText(context, en: productName, bn: productNameBn)}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${strings.category}: ${LocalizationService.getText(context, en: categoryName, bn: categoryNameBn)}",
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  const SizedBox(height: 6),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _priceTag(
                              strings.purchase,
                              "${CurrencyFormatter.format(int.tryParse(stockData?.purchaseRate ?? '0'), context: context)} Tk",
                              AppColors.warning,
                            ),
                            _priceTag(
                              strings.sales,
                              "${CurrencyFormatter.format(int.tryParse(stockData?.salesRate ?? '0'), context: context)} Tk",
                              AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            _priceTag(
                              strings.totalPurchased,
                              CurrencyFormatter.format(int.tryParse(stockData?.totalPurchased ?? '0'), context: context),
                              AppColors.success,
                            ),
                            _priceTag(
                              strings.totalSold,
                              CurrencyFormatter.format(int.tryParse(stockData?.totalSold ?? '0'), context: context),
                              AppColors.info,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  Text(
                    "${strings.currentStocks}: ${CurrencyFormatter.format(int.tryParse(stockData?.remainingStock ?? '0'), context: context)} ${strings.pcs}",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: stockData?.remainingStock == '0'
                              ? AppColors.error
                              : AppColors.success,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _priceTag(String label, String? value, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$label: ${value ?? '0'}",
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: color,
          ),
        ),
      ),
    );
  }
}
