import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/features/sales/data/models/sales_record_model.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class SalesRecordCard extends StatelessWidget {
  final SalesRecord? salesRecord;

  const SalesRecordCard({super.key, required this.salesRecord});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    final product = salesRecord?.salesProduct?.isNotEmpty == true
        ? salesRecord!.salesProduct!.first
        : null;

    final customerName = product?.customer?.customerName ?? 'N/A';
    final customerNameBn = product?.customer?.customerNameBangla ?? 'N/A';
    final productName = product?.product?.productName ?? 'N/A';
    final productNameBn = product?.product?.productNameBangla ?? 'N/A';
    final categoryName = product?.category?.name ?? 'N/A';
    final categoryNameBn = product?.category?.nameBangla ?? 'N/A';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
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
                    DateFormatters.readableDate(
                        context, salesRecord?.saleDate?.toString()),
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                  Text(
                    "${strings.invoice}: ${salesRecord?.invoiceNo ?? 'N/A'}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: AppColors.primaryColor),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "${strings.category}: ${LocalizationService.getText(context, en: categoryName, bn: categoryNameBn)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: AppColors.lightFontColor),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _priceTag(
                            strings.price,
                            CurrencyFormatter.format(
                                int.tryParse(product?.salePrice ?? '0'),
                                context: context),
                          ),
                          if ((product?.total ?? '0') != '0')
                            _priceTag(
                              strings.total,
                              CurrencyFormatter.format(
                                  int.tryParse(product?.total ?? '0'),
                                  context: context),
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

  Widget _priceTag(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$label: $value Tk",
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
