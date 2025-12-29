import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/features/accounts/data/models/balance_sheet_model.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

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
                AppLocalizations.of(context)!.balanceSheetSummary,
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
                  _buildRow(context, AppLocalizations.of(context)!.totalSales, balanceData?.totalSales, AppColors.success),
                  _buildRow(context, AppLocalizations.of(context)!.totalPurchase, balanceData?.totalPurchase, AppColors.warning),
                  _buildRow(context, AppLocalizations.of(context)!.cashReceived, balanceData?.cashReceived, AppColors.success),
                  _buildRow(context, AppLocalizations.of(context)!.cashPaid, balanceData?.cashPaid, AppColors.warning),
                  _buildRow(context, AppLocalizations.of(context)!.bankDeposit, balanceData?.bankDeposit, AppColors.success),
                  _buildRow(context, AppLocalizations.of(context)!.bankWithdraw, balanceData?.bankWithdraw, AppColors.warning),
                  _buildRow(context, AppLocalizations.of(context)!.supplierPaymentPaid, balanceData?.supplierPaymentPaid, AppColors.warning),
                  _buildRow(context, AppLocalizations.of(context)!.supplierPaymentReceive, balanceData?.supplierPaymentReceive, AppColors.success),
                  _buildRow(context, AppLocalizations.of(context)!.customerPaymentPaid, balanceData?.customerPaymentPaid, AppColors.warning),
                  _buildRow(context, AppLocalizations.of(context)!.customerPaymentReceive, balanceData?.customerPaymentReceive, AppColors.success),
                  _buildRow(context, AppLocalizations.of(context)!.employeePayment, balanceData?.employeePayment, AppColors.warning),
                  _buildRow(context, AppLocalizations.of(context)!.cashIn, balanceData?.cashIn, AppColors.success),
                  _buildRow(context, AppLocalizations.of(context)!.cashOut, balanceData?.cashOut, AppColors.warning),
                  _buildRow(context, AppLocalizations.of(context)!.cashBalance, balanceData?.cashBalance, AppColors.primaryColor),

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
              value != null ? "${CurrencyFormatter.format(value, context: context)} Tk" : '0.00 Tk',
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
