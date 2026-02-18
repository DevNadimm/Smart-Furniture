import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/features/admin/data/models/purchase_model.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class PurchaseCard extends StatelessWidget {
  final PurchaseData purchase;
  final VoidCallback? onTap;

  const PurchaseCard({
    super.key,
    required this.purchase,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

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
              color: _getStatusColor().withValues(alpha: 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      purchase.purchaseNo ?? strings.notAvailable,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: _getStatusColor(),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getLocalizedStatus(context, purchase.status ?? strings.notAvailable),
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Body
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Supplier Name
                    if (purchase.supplierName != null && purchase.supplierName!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocalizationService.getText(context, en: purchase.supplierName!, bn: purchase.supplierNameBn),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey.withValues(alpha: 0.8),
                            ),
                          ),
                          const SizedBox(height: 6),
                        ],
                      ),
                    const Divider(color: AppColors.borderColor, thickness: 1),
                    const SizedBox(height: 6),

                    /// Purchase Date
                    if (purchase.purchaseDate != null && purchase.purchaseDate!.isNotEmpty)
                      _buildInfoRow(
                        context,
                        icon: HugeIcons.strokeRoundedCalendar03,
                        label: strings.purchaseDate,
                        value: purchase.purchaseDate!,
                      ),

                    const SizedBox(height: 8),
                    const Divider(color: AppColors.borderColor, thickness: 1),
                    const SizedBox(height: 8),

                    /// Financial Summary
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildFinancialTag(
                          context,
                          label: strings.grandTotal,
                          value: '৳${CurrencyFormatter.format(num.tryParse(purchase.grandTotal?.toStringAsFixed(2) ?? '0.00'), context: context)}',
                          icon: HugeIcons.strokeRoundedShoppingCart01,
                        ),
                        _buildFinancialTag(
                          context,
                          label: strings.paid,
                          value: '৳${CurrencyFormatter.format(num.tryParse(purchase.paidAmount?.toStringAsFixed(2) ?? '0.00'), context: context)}',
                          icon: HugeIcons.strokeRoundedWallet01,
                        ),
                        _buildFinancialTag(
                          context,
                          label: strings.due,
                          value: '৳${CurrencyFormatter.format(num.tryParse(purchase.dueAmount?.toStringAsFixed(2) ?? '0.00'), context: context)}',
                          icon: HugeIcons.strokeRoundedReceiptDollar,
                          isDue: true,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// View Details Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: onTap,
                          icon: const HugeIcon(
                            icon: HugeIcons.strokeRoundedArrowRight01,
                            color: AppColors.primaryColor,
                            size: 18,
                          ),
                          label: Text(
                            strings.viewDetails,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        int maxLines = 1,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HugeIcon(
            icon: icon,
            color: AppColors.primaryColor,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: maxLines,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialTag(
      BuildContext context, {
        required String label,
        required String value,
        required IconData icon,
        bool isDue = false,
      }) {
    return Column(
      children: [
        HugeIcon(
          icon: icon,
          color: isDue ? Colors.red : AppColors.primaryColor,
          size: 20,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 11,
            color: AppColors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isDue ? Colors.red : AppColors.grey,
          ),
        ),
      ],
    );
  }

  String _getLocalizedStatus(BuildContext context, String status) {
    final strings = AppLocalizations.of(context)!;
    final lowerStatus = status.toLowerCase();

    if (lowerStatus.contains('paid') || lowerStatus.contains('complete')) {
      return strings.statusCompleted;
    } else if (lowerStatus.contains('partial')) {
      return strings.statusPartial;
    } else if (lowerStatus.contains('pending')) {
      return strings.statusPending;
    } else if (lowerStatus.contains('due')) {
      return strings.statusDue;
    } else {
      return status;
    }
  }

  Color _getStatusColor() {
    final status = purchase.status?.toLowerCase() ?? '';
    if (status.contains('paid') || status.contains('complete')) {
      return Colors.green;
    } else if (status.contains('partial')) {
      return Colors.orange;
    } else if (status.contains('pending') || status.contains('due')) {
      return Colors.red;
    } else {
      return AppColors.primaryColor;
    }
  }
}