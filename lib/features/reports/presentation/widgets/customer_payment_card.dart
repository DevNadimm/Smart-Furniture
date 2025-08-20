import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/reports/data/models/customer_payment_model.dart';

class CustomerPaymentCard extends StatelessWidget {
  final CustomerPaymentModel customerPayment;

  const CustomerPaymentCard({
    super.key,
    required this.customerPayment,
  });

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    final customer = customerPayment.customer;
    final summary = customerPayment.summary;

    final customerName = customer?.customerName ?? 'N/A';
    final customerNameBn = customer?.customerNameBangla ?? 'N/A';

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
            // Header: Customer Name
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: AppColors.primaryColor.withOpacity(0.1),
              child: Text(
                "${strings.customer}: ${LocalizationService.getText(context, en: customerName, bn: customerNameBn)}",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (customer?.mobile != null) ...[
                    Text(
                      "${strings.mobile}: ${customer!.mobile}",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.lightFontColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                  ],

                  if (customer?.address != null) ...[
                    Text(
                      "${strings.address}: ${customer!.address}",
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _priceTag(
                            strings.previousDue,
                            "${CurrencyFormatter.format(int.tryParse(customer?.previousDue ?? '0') ?? 0, context: context)} Tk",
                            AppColors.warning,
                          ),
                          _priceTag(
                            strings.creditLimit,
                            "${CurrencyFormatter.format(int.tryParse(customer?.creditLimit ?? '0') ?? 0, context: context)} Tk",
                            AppColors.success,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _priceTag(
                            strings.total,
                            "${CurrencyFormatter.format(summary?.totalAmount ?? 0, context: context)} Tk",
                            AppColors.primaryColor,
                          ),
                          _priceTag(
                            strings.paid,
                            "${CurrencyFormatter.format(summary?.totalPaid ?? 0, context: context)} Tk",
                            AppColors.success,
                          ),
                          _priceTag(
                            strings.due,
                            "${CurrencyFormatter.format(summary?.totalDue ?? 0, context: context)} Tk",
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

  Widget _priceTag(String label, String value, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        "$label: $value",
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
