import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/features/purchase/data/models/purchase_return_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PurchaseReturnCard extends StatelessWidget {
  final ReturnData? returnData;

  const PurchaseReturnCard({super.key, required this.returnData});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final product = returnData?.product;
    final supplier = returnData?.supplier;

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormatters.readableDate(context, returnData?.returnDate ?? '').toString(),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    "${strings.invoice}: ${returnData?.invoiceNo ?? 'N/A'}",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${strings.supplier}: ${LocalizationService.getText(context, en: supplier?.supplierName ?? 'N/A', bn: supplier?.supplierNameBangla ?? 'N/A')}",
                    style: Theme.of(context).textTheme.headlineSmall,
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
                            Text(
                              "${strings.product}: ${LocalizationService.getText(context, en: product?.productName ?? 'N/A', bn: product?.productNameBangla ?? 'N/A')}",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _priceTag(
                            AppLocalizations.of(context)!.returnRate,
                            "${CurrencyFormatter.format(int.tryParse(returnData?.returnRate ?? '0'), context: context)} Tk",
                            AppColors.primaryColor,
                          ),
                          _priceTag(
                            AppLocalizations.of(context)!.returnQuantity,
                            CurrencyFormatter.format(int.tryParse(returnData?.returnQuantity ?? '0'), context: context),
                            AppColors.warning,
                          ),
                          _priceTag(
                            AppLocalizations.of(context)!.returnAmount,
                            "${CurrencyFormatter.format(int.tryParse(returnData?.returnAmount ?? '0'), context: context)} Tk",
                            AppColors.success,
                          ),
                        ],
                      )
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

  Widget _priceTag(String label, dynamic value, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$label: ${value ?? '0.00'}",
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
