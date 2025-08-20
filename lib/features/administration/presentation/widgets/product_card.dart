import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/administration/data/models/product_list_model.dart';

class ProductCard extends StatelessWidget {
  final ProductData? product;

  const ProductCard({super.key, required this.product});

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
                product?.category?.name ?? 'Uncategorized',
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
                  Text(
                    "${strings.product}: ${LocalizationService.getText(context, en: product?.productName ?? 'N/A', bn: product?.productNameBangla ?? 'N/A')}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (product?.brand != null && product!.brand!.isNotEmpty)
                    Text(
                      "${strings.brand}: ${product?.brand ?? "N/A"}",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.lightFontColor),
                    ),
                  const SizedBox(height: 6),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  const SizedBox(height: 1),
                  _priceTag(
                    strings.purchaseRate,
                    "${CurrencyFormatter.format(int.tryParse(product?.purchaseRate ?? '0'), context: context)} Tk",
                    AppColors.warning,
                  ),
                  _priceTag(
                    strings.salesRate,
                    "${CurrencyFormatter.format(int.tryParse(product?.salesRate ?? '0'), context: context)} Tk",
                    AppColors.success,
                  ),
                  if (product?.wholesaleRate != null)
                    _priceTag(
                      strings.wholesaleRate,
                      "${CurrencyFormatter.format(int.tryParse(product?.wholesaleRate ?? '0'), context: context)} Tk",
                      AppColors.primaryColor,
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
