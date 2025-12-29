import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/features/accounts/data/models/cash_transaction_model.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class CashTransactionCard extends StatelessWidget {
  final CashTransactionData? transaction;

  const CashTransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    String capitalize(String? s) {
      if (s == null || s.isEmpty) return 'Unknown Type';
      return s[0].toUpperCase() + s.substring(1);
    }

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
                    DateFormatters.readableDate(context, transaction?.date ?? '').toString(),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    "ID: ${transaction?.transactionId ?? 'N/A'}",
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
                    capitalize(transaction?.transactionType),
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
                              transaction?.accountName ?? 'Unknown Account',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              transaction?.description ?? 'No Description',
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
                          _amountTag(
                            strings.received,
                            "${CurrencyFormatter.format(int.tryParse(transaction?.receivedAmount ?? '0'), context: context)} Tk",
                            AppColors.success,
                          ),
                          _amountTag(
                            strings.paid,
                            "${CurrencyFormatter.format(int.tryParse(transaction?.paidAmount ?? '0'), context: context)} Tk",
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

  Widget _amountTag(String label, dynamic value, Color color) {
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
