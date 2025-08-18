import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/features/daily_reports/data/models/daily_reports_model.dart';

class EmployeePaymentCard extends StatelessWidget {
  final EmployeePayment? employeePayment;

  const EmployeePaymentCard({super.key, required this.employeePayment});

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
                    DateFormatters.readableDate(employeePayment?.date ?? ""),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    "Month: ${employeePayment?.month ?? 'N/A'}",
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
                    employeePayment?.employee?.name ?? employeePayment?.name ?? "Unknown Employee",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (employeePayment?.employee?.designation != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      employeePayment!.employee!.designation!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.lightFontColor,
                      ),
                    ),
                  ],

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
                            if (employeePayment?.employee?.department != null)
                              Text(
                                employeePayment!.employee!.department!,
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            if (employeePayment?.employee?.contact != null)
                              Text(
                                employeePayment!.employee!.contact!,
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
                            "Payment",
                            "${CurrencyFormatter.format(int.tryParse(employeePayment?.paymentAmount ?? "0"))} Tk",
                          ),
                          if (employeePayment?.deductedAmount != null)
                            _priceTag(
                              "Deducted",
                              "${CurrencyFormatter.format(int.tryParse(employeePayment?.deductedAmount ?? "0"))} Tk",
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
        "$label: $value",
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
