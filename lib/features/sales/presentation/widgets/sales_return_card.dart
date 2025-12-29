import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/features/sales/data/models/sales_return_model.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class SalesReturnCard extends StatelessWidget {
  final SalesReturnData? salesReturn;

  const SalesReturnCard({super.key, required this.salesReturn});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final customerName = salesReturn?.customer?.customerName ?? 'N/A';
    final customerNameBn = salesReturn?.customer?.customerNameBangla ?? 'N/A';
    final productName = salesReturn?.product?.productName ?? 'N/A';
    final productNameBn = salesReturn?.product?.productNameBangla ?? 'N/A';

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
                    DateFormatters.readableDate(context, salesReturn?.returnDate).toString(),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    "${strings.invoice}: ${salesReturn?.invoiceNo ?? 'N/A'}",
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
                    "${strings.customer}: ${LocalizationService.getText(context, en: customerName, bn: customerNameBn)}",
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
                              "${strings.product}: ${LocalizationService.getText(context, en: productName, bn: productNameBn)}",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600,),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _priceTag(
                            strings.price,
                            "${CurrencyFormatter.format(int.tryParse(salesReturn?.returnRate ?? '0'), context: context)} Tk",
                            AppColors.primaryColor,
                          ),
                          _priceTag(
                            strings.quantity,
                            CurrencyFormatter.format(int.tryParse(salesReturn?.returnQuantity ?? '0'), context: context),
                            AppColors.warning,
                          ),
                          _priceTag(
                            strings.amount,
                            "${CurrencyFormatter.format(int.tryParse(salesReturn?.returnAmount ?? '0'), context: context)} Tk",
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
