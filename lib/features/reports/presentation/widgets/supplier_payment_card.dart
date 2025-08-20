import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/reports/data/models/supplier_payment_model.dart';

class SupplierPaymentCard extends StatelessWidget {
  final  Invoice? invoice;
  final Supplier? supplier;

  const SupplierPaymentCard({
    super.key,
    required this.invoice,
    required this.supplier,
  });

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final supplierName = supplier?.supplierName ?? 'N/A';
    final supplierNameBn = supplier?.supplierNameBangla ?? 'N/A';

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
                    DateFormatters.readableDate(context, invoice?.invoiceDate ?? ''),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    "${strings.invoice}: ${invoice?.invoiceNo ?? '-'}",
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
                    "${strings.supplier}: ${LocalizationService.getText(context, en: supplierName, bn: supplierNameBn)}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  if (invoice?.note != null) ...[
                    Text(
                      "Note: ${invoice?.note}",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.lightFontColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],
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
                              "${strings.type}: ${invoice?.type?.toUpperCase() ?? "N/A"}",
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "${invoice?.status?[0].toUpperCase()}${invoice?.status?.substring(1)}",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: AppColors.lightFontColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _priceTag(
                            strings.total,
                            "${CurrencyFormatter.format(int.tryParse(invoice?.totalAmount ?? '0'), context: context)} Tk",
                            AppColors.primaryColor,
                          ),
                          _priceTag(
                            strings.paid,
                            "${CurrencyFormatter.format(int.tryParse(invoice?.totalPaid ?? '0'), context: context)} Tk",
                            AppColors.success,
                          ),
                          _priceTag(
                            strings.due,
                            "${CurrencyFormatter.format(int.tryParse(invoice?.totalDue ?? '0'), context: context)} Tk",
                            AppColors.warning,
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
