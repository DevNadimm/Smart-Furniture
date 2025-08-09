import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/features/hr_and_payroll/data/models/salary_payment_model.dart';

class SalaryPaymentCard extends StatelessWidget {
  final SalaryPaymentModel? salaryPayment;

  const SalaryPaymentCard({super.key, required this.salaryPayment});

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
                    DateFormatters.readableDate(salaryPayment?.date),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.primaryColor,
                        ),
                  ),
                  Text(
                    salaryPayment?.month ?? "-",
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
                    salaryPayment?.name ?? "Unknown Employee",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (salaryPayment?.employee?.empId != null)
                    Text(
                      "ID: ${salaryPayment?.employee?.empId}",
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
                        "Payment",
                        salaryPayment?.paymentAmount,
                        AppColors.success,
                      ),
                      _priceTag(
                        "Deduction",
                        salaryPayment?.deductedAmount,
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
