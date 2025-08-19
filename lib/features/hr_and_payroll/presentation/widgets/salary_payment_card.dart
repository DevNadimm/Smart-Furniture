import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/hr_and_payroll/data/models/salary_payment_model.dart';

class SalaryPaymentCard extends StatelessWidget {
  final SalaryPaymentData? salaryPaymentData;

  const SalaryPaymentCard({super.key, required this.salaryPaymentData});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final employeeName = salaryPaymentData?.name ?? "Unknown Employee";
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
                    DateFormatters.readableDate(context, salaryPaymentData?.date),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.primaryColor,
                        ),
                  ),
                  Text(
                    salaryPaymentData?.month ?? "N/A",
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
                    employeeName,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (salaryPaymentData?.employee?.empId != null)
                    Text(
                      "ID: ${salaryPaymentData?.employee?.empId}",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.lightFontColor,
                          ),
                    ),
                  const SizedBox(height: 6),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _priceTag(
                        strings.payment,
                        "${CurrencyFormatter.format(int.tryParse(salaryPaymentData?.paymentAmount ?? '0'), context: context)} Tk",
                        AppColors.success,
                      ),
                      _priceTag(
                        strings.deduction,
                        "${CurrencyFormatter.format(int.tryParse(salaryPaymentData?.deductedAmount ?? '0'), context: context)} Tk",
                        AppColors.warning,
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
}
