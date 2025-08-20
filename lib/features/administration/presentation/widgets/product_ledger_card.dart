import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/administration/data/models/product_ledger_model.dart';

class ProductLedgerCard extends StatelessWidget {
  final ProductLedgerData? ledgerData;

  const ProductLedgerCard({super.key, required this.ledgerData});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final personName = ledgerData?.personName ?? 'N/A';
    final personNameBn = ledgerData?.personNameBangla ?? 'N/A';

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
                    DateFormatters.readableDate(context, ledgerData?.date ?? '').toString(),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    "${strings.invoice}: ${ledgerData?.invoiceNo ?? 'N/A'}",
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
                    "${strings.brand}: ${LocalizationService.getText(context, en: personName, bn: personNameBn)}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${strings.type}: ${ledgerData?.type?[0].toUpperCase()}${ledgerData?.type?.substring(1)}",
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${strings.price}: ${CurrencyFormatter.format(int.tryParse(ledgerData?.rate ?? '0.00'), context: context)} Tk",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: AppColors.lightFontColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _quantityTag(
                            strings.inQuantity,
                            CurrencyFormatter.format(ledgerData?.inQty ?? 0, context: context),
                          ),
                          _quantityTag(
                            strings.outQuantity,
                            CurrencyFormatter.format(ledgerData?.outQty ?? 0, context: context),
                          ),
                        ],
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

  Widget _quantityTag(String label, String? value) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$label: ${value ?? '0'}",
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
