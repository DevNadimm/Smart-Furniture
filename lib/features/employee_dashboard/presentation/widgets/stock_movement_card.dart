import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/stock_register_model.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class StockMovementCard extends StatelessWidget {
  final StockMovement? movement;

  const StockMovementCard({super.key, required this.movement});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    final inQty = num.tryParse(movement?.inQuantity ?? '0') ?? 0;
    final bool isIn = inQty > 0;
    final Color typeColor = isIn ? AppColors.success : AppColors.error;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: [
            /// Header
            Container(
              width: double.infinity,
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              color: typeColor.withValues(alpha: 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Type badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: typeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HugeIcon(
                          icon: isIn
                              ? HugeIcons.strokeRoundedArrowDown01
                              : HugeIcons.strokeRoundedArrowUp01,
                          color: typeColor,
                          size: 13,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          movement?.type ?? strings.notAvailable,
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: typeColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Date
                  Row(
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedCalendar03,
                        color: AppColors.grey,
                        size: 13,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormatters.readableDate(context, movement?.date),
                        style:
                        Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.grey,
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
                children: [
                  /// Reference
                  if (movement?.reference != null &&
                      movement!.reference!.isNotEmpty) ...[
                    _infoRow(
                      context,
                      icon: HugeIcons.strokeRoundedFile02,
                      label: strings.reference,
                      value: movement!.reference!,
                    ),
                    const Divider(
                        color: AppColors.borderColor, thickness: 1),
                    const SizedBox(height: 6),
                  ],

                  /// In / Out / Balance tiles
                  Row(
                    children: [
                      Expanded(
                        child: _amountTile(
                          context,
                          icon: HugeIcons.strokeRoundedArrowDown01,
                          label: strings.inQuantity,
                          value: CurrencyFormatter.format(
                            num.tryParse(movement?.inQuantity ?? '0'),
                            context: context,
                          ),
                          color: AppColors.success,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _amountTile(
                          context,
                          icon: HugeIcons.strokeRoundedArrowUp01,
                          label: strings.outQuantity,
                          value: CurrencyFormatter.format(
                            num.tryParse(movement?.outQuantity ?? '0'),
                            context: context,
                          ),
                          color: AppColors.error,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _amountTile(
                          context,
                          icon: HugeIcons.strokeRoundedSafe,
                          label: strings.balanceAfter,
                          value: CurrencyFormatter.format(
                            num.tryParse(movement?.balanceAfter ?? '0'),
                            context: context,
                          ),
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),

                  /// Created By
                  if (movement?.createdBy != null &&
                      movement!.createdBy!.isNotEmpty) ...[
                    const SizedBox(height: 6),
                    _infoRow(
                      context,
                      icon: HugeIcons.strokeRoundedUser,
                      label: strings.createdBy,
                      value: movement!.createdBy!,
                    ),
                  ],

                  /// Notes
                  if (movement?.notes != null &&
                      movement!.notes!.isNotEmpty) ...[
                    _infoRow(
                      context,
                      icon: HugeIcons.strokeRoundedNote01,
                      label: strings.notes,
                      value: movement!.notes!,
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

  Widget _infoRow(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HugeIcon(icon: icon, color: AppColors.primaryColor, size: 16),
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _amountTile(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        required Color color,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HugeIcon(icon: icon, color: color, size: 15),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}