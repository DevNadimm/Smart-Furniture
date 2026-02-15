import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/customer_purchase_due_model.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/due_payment_page.dart';

class CustomerSaleDueCard extends StatelessWidget {
  final CustomerSaleData sale;
  final int customerId;

  const CustomerSaleDueCard({
    super.key,
    required this.sale,
    required this.customerId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            /// Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedReceiptDollar,
                        color: AppColors.primaryColor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        sale.saleNo ?? 'N/A',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedCalendar03,
                        color: AppColors.primaryColor,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        sale.saleDateFormatted ?? 'N/A',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Financial Summary
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildAmountItem(
                        context,
                        label: 'Grand Total',
                        amount: sale.grandTotal ?? 0,
                        icon: HugeIcons.strokeRoundedShoppingCart01,
                        color: AppColors.grey,
                      ),
                      Container(
                        height: 50,
                        width: 1,
                        color: AppColors.borderColor,
                      ),
                      _buildAmountItem(
                        context,
                        label: 'Paid',
                        amount: sale.paidAmount ?? 0,
                        icon: HugeIcons.strokeRoundedCheckmarkCircle02,
                        color: Colors.green,
                      ),
                      Container(
                        height: 50,
                        width: 1,
                        color: AppColors.borderColor,
                      ),
                      _buildAmountItem(
                        context,
                        label: 'Due',
                        amount: sale.dueAmount ?? 0,
                        icon: HugeIcons.strokeRoundedAlertCircle,
                        color: Colors.red,
                      ),
                    ],
                  ),

                  /// Pay Due Button
                  if ((sale.dueAmount ?? 0) > 0) ...[
                    const SizedBox(height: 12),
                    const Divider(color: AppColors.borderColor, thickness: 1),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            DuePaymentPage.route(
                              customerId: customerId,
                              saleId: sale.id ?? 0,
                              saleNo: sale.saleNo ?? 'N/A',
                              dueAmount: sale.dueAmount ?? 0,
                            ),
                          );
                        },
                        icon: const HugeIcon(
                          icon: HugeIcons.strokeRoundedWallet01,
                          color: AppColors.white,
                          size: 20,
                        ),
                        label: Text(
                          'Pay Due',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountItem(
      BuildContext context, {
        required String label,
        required int amount,
        required IconData icon,
        required Color color,
      }) {
    return Column(
      children: [
        HugeIcon(
          icon: icon,
          color: color,
          size: 24,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 11,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '৳$amount',
          style: GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}