import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/accounts/data/models/bank_transaction_model.dart';

class BankTransactionCard extends StatelessWidget {
  final BankTransactionData? transaction;

  const BankTransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

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
                    DateFormatters.readableDate(context, transaction?.transactionDate ?? ''),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    _capitalize(transaction?.transactionType ?? '-'),
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
                    "${strings.accountName}: ${transaction?.accountName ?? 'N/A'}",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${strings.bank}: ${transaction?.bankName ?? 'N/A'} - ${transaction?.accountNumber ?? ''}",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.lightFontColor,
                    ),
                  ),
                  if (transaction?.note != null && transaction!.note!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      transaction!.note!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.lightFontColor,
                      ),
                    ),
                  ],
                  const SizedBox(height: 6),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  const SizedBox(height: 6),
                  _priceTag(
                    strings.deposit,
                    "${CurrencyFormatter.format(int.tryParse(transaction?.deposit ?? '0'), context: context)} Tk",
                    AppColors.success,
                  ),
                  const SizedBox(height: 6),
                  _priceTag(
                    strings.withdraw,
                    "${CurrencyFormatter.format(int.tryParse(transaction?.withdraw ?? '0'), context: context)} Tk",
                    AppColors.warning,
                  ),
                  const SizedBox(height: 6),
                  _priceTag(
                    strings.amount,
                    "${CurrencyFormatter.format(int.tryParse(transaction?.amount ?? '0'), context: context)} Tk",
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

  String _capitalize(String value) {
    if (value.isEmpty) return value;
    return value[0].toUpperCase() + value.substring(1);
  }
}
