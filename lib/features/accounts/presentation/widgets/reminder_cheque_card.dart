import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/features/accounts/data/models/reminder_cheque_list_model.dart';

class ReminderChequeCard extends StatelessWidget {
  final ReminderChequeData? chequeData;

  const ReminderChequeCard({super.key, required this.chequeData});

  @override
  Widget build(BuildContext context) {
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
                    DateFormatters.readableDate(
                      context,
                      chequeData?.chequeDate.toString(),
                    ).toString(),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  _statusTag(chequeData?.chequeStatus ?? ''),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chequeData?.bankName ?? 'Unknown Bank',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Cheque No: ${chequeData?.chequeNumber ?? 'N/A'}",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.lightFontColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  const SizedBox(height: 6),
                  _priceTag(
                    "Amount",
                    "${CurrencyFormatter.format(int.tryParse(chequeData?.chequeAmount ?? '0'))} Tk",
                    AppColors.primaryColor,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Issue Date: ${DateFormatters.readableDate(context, chequeData?.date)}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "Reminder Date: ${DateFormatters.readableDate(context, chequeData?.reminderDate)}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "Submit Date: ${DateFormatters.readableDate(context, chequeData?.submitDate)}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (chequeData?.description?.isNotEmpty == true) ...[
                    const SizedBox(height: 8),
                    Text(
                      chequeData!.description!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.lightFontColor,
                      ),
                    ),
                  ]
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

  Widget _statusTag(String status) {
    if (status.isEmpty) return const SizedBox();
    return Text(
      "${status[0].toUpperCase()}${status.substring(1)}",
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
