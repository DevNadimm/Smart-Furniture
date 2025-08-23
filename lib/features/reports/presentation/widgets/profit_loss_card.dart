import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/reports/data/models/profit_loss_model.dart';

class ProfitLossCard extends StatelessWidget {
  final ProfitLossModel? profitLoss;

  const ProfitLossCard({super.key, required this.profitLoss});

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
                AppLocalizations.of(context)!.profitLossSummary,
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
                  _buildRow(context, AppLocalizations.of(context)!.totalPurchased, profitLoss?.totalPurchased, AppColors.warning),
                  _buildRow(context, AppLocalizations.of(context)!.totalSold, profitLoss?.totalSold, AppColors.success),
                  _buildRow(context, AppLocalizations.of(context)!.totalDiscount, profitLoss?.totalDiscount, Colors.orange),
                  _buildRow(context, AppLocalizations.of(context)!.totalReturned, profitLoss?.totalReturnedValue, AppColors.error),
                  _buildRow(context, AppLocalizations.of(context)!.totalDamaged, profitLoss?.totalDamaged, Colors.redAccent),
                  _buildRow(
                    context,
                    AppLocalizations.of(context)!.totalCashTransaction,
                    profitLoss?.totalCashTransaction,
                    Colors.teal,
                  ),
                  _buildRow(
                    context,
                    AppLocalizations.of(context)!.totalEmployeePayment,
                    profitLoss?.totalEmployeePayment,
                    Colors.blueGrey,
                  ),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  _buildRow(
                    context,
                    AppLocalizations.of(context)!.totalProfit,
                    profitLoss?.totalProfit,
                    (profitLoss?.totalProfit ?? 0) >= 0 ? AppColors.success : AppColors.error,
                  ),
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
              value != null
                  ? "${CurrencyFormatter.format(value, context: context)} Tk"
                  : '0.00 Tk',
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
