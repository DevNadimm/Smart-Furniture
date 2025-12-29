import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/features/administration/data/models/supplier_list_model.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class SupplierCard extends StatelessWidget {
  final SupplierData? supplier;

  const SupplierCard({super.key, required this.supplier});

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
                    '${strings.id}: ${supplier?.supplierId ?? 'N/A'}',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  if (supplier?.email?.isNotEmpty ?? false)
                    Expanded(
                      child: Text(
                        '  ${supplier?.email}',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.primaryColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.end,
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
                  // Supplier Name
                  Text(
                    "${strings.supplier}: ${LocalizationService.getText(context, en: supplierName, bn: supplierNameBn)}",
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
                            _infoText(strings.contact, supplier?.contactPerson ?? 'N/A'),
                            _infoText(strings.mobile, supplier?.contactNumber ?? 'N/A'),
                            _infoText(strings.address, supplier?.address ?? 'N/A'),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _priceTag(
                            strings.previousDue,
                            "${CurrencyFormatter.format(int.tryParse(supplier?.previousDue ?? '0'), context: context)} Tk",
                            AppColors.warning,
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

  Widget _infoText(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text(
        "$label: $value",
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: AppColors.lightFontColor,
        ),
      ),
    );
  }
}
