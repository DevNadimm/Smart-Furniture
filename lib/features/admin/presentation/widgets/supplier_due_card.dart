import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/features/admin/data/models/supplier_dues_model.dart';
import 'package:smart_furniture/features/admin/presentation/pages/supplier_due_details_page.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class SupplierDueCard extends StatelessWidget {
  final SupplierDueData supplierDue;

  const SupplierDueCard({
    super.key,
    required this.supplierDue,
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
              color: _getDueStatusColor().withValues(alpha: 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      LocalizationService.getText(context, en: supplierDue.name ?? strings.notAvailable, bn: supplierDue.nameBn),
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                        color: _getDueStatusColor(),
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
                      color: _getDueStatusColor(),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '৳${CurrencyFormatter.format(supplierDue.due ?? 0, context: context)}',
                      style: GoogleFonts.poppins(
                        fontSize: 13,
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
              onTap: () {
                Navigator.push(
                  context,
                  SupplierDueDetailsPage.route(
                    supplierId: supplierDue.id ?? 0,
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),

                    /// Phone
                    if (supplierDue.phone != null && supplierDue.phone!.isNotEmpty)
                      _buildInfoRow(
                        context,
                        icon: HugeIcons.strokeRoundedCall,
                        label: strings.phone,
                        value: supplierDue.phone!,
                      ),

                    /// Email
                    if (supplierDue.email != null && supplierDue.email!.isNotEmpty)
                      _buildInfoRow(
                        context,
                        icon: HugeIcons.strokeRoundedMail01,
                        label: strings.email,
                        value: supplierDue.email!,
                      ),

                    /// Address
                    if (supplierDue.address != null && supplierDue.address!.isNotEmpty)
                      _buildInfoRow(
                        context,
                        icon: HugeIcons.strokeRoundedLocation01,
                        label: strings.address,
                        value: supplierDue.address!,
                        maxLines: 2,
                      ),

                    const SizedBox(height: 6),
                    const Divider(color: AppColors.borderColor, thickness: 1),
                    const SizedBox(height: 8),

                    /// Financial Summary
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildFinancialTag(
                          context,
                          label: strings.totalPurchasesLabel,
                          value: '৳${CurrencyFormatter.format(supplierDue.totalPurchases ?? 0, context: context)}',
                          icon: HugeIcons.strokeRoundedShoppingCart01,
                        ),
                        _buildFinancialTag(
                          context,
                          label: strings.paid,
                          value: '৳${CurrencyFormatter.format(supplierDue.totalPaid ?? 0, context: context)}',
                          icon: HugeIcons.strokeRoundedWallet01,
                        ),
                        _buildFinancialTag(
                          context,
                          label: strings.duePurchases,
                          value: CurrencyFormatter.format(supplierDue.duePurchaseCount ?? 0, context: context),
                          icon: HugeIcons.strokeRoundedReceiptDollar,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    /// View Details Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              SupplierDueDetailsPage.route(
                                supplierId: supplierDue.id ?? 0,
                              ),
                            );
                          },
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
      }) {
    return Column(
      children: [
        HugeIcon(
          icon: icon,
          color: AppColors.primaryColor,
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
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.grey,
          ),
        ),
      ],
    );
  }

  Color _getDueStatusColor() {
    final due = supplierDue.due ?? 0;
    if (due > 50000) {
      return Colors.red;
    } else if (due > 20000) {
      return Colors.orange;
    } else {
      return AppColors.primaryColor;
    }
  }
}