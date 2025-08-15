import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/features/accounts/data/models/balance_sheet_model.dart';

class BalanceSheetCard extends StatelessWidget {
  final BalanceSheetData? balanceData;

  const BalanceSheetCard({super.key, required this.balanceData});

  @override
  Widget build(BuildContext context) {
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
                "Balance Sheet Summary",
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  _buildRow(context, "Total Sales", balanceData?.totalSales, AppColors.success),
                  _buildRow(context, "Total Purchase", balanceData?.totalPurchase, AppColors.warning),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  _buildRow(context, "Cash Received", balanceData?.cashReceived, AppColors.success),
                  _buildRow(context, "Cash Paid", balanceData?.cashPaid, AppColors.warning),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  _buildRow(context, "Bank Deposit", balanceData?.bankDeposit, AppColors.success),
                  _buildRow(context, "Bank Withdraw", balanceData?.bankWithdraw, AppColors.warning),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  _buildRow(context, "Supplier Payment Paid", balanceData?.supplierPaymentPaid, AppColors.warning),
                  _buildRow(context, "Supplier Payment Receive", balanceData?.supplierPaymentReceive, AppColors.success),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  _buildRow(context, "Customer Payment Paid", balanceData?.customerPaymentPaid, AppColors.warning),
                  _buildRow(context, "Customer Payment Receive", balanceData?.customerPaymentReceive, AppColors.success),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  _buildRow(context, "Employee Payment", balanceData?.employeePayment, AppColors.warning),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  _buildRow(context, "Cash In", balanceData?.cashIn, AppColors.success),
                  _buildRow(context, "Cash Out", balanceData?.cashOut, AppColors.warning),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  _buildRow(context, "Cash Balance", balanceData?.cashBalance, AppColors.primaryColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context, String label, num? value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value != null ? "${CurrencyFormatter.format(value)} Tk" : '0.00 Tk',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: color,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
