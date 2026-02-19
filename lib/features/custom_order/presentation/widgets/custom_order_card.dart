import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/features/custom_order/data/models/custom_order_model.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class CustomOrderCard extends StatelessWidget {
  final CustomOrderData order;
  final VoidCallback onTap;
  final VoidCallback? onPayDue;

  const CustomOrderCard({
    super.key,
    required this.order,
    required this.onTap,
    this.onPayDue,
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
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      order.orderNo ?? strings.notAvailable,
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.primaryColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _statusTag(context, order.status ?? ''),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Customer Name
                  if (order.customer?.name != null && order.customer!.name!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const HugeIcon(
                              icon: HugeIcons.strokeRoundedUser,
                              color: AppColors.grey,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                LocalizationService.getText(
                                  context,
                                  en: order.customer?.name ?? strings.notAvailable,
                                  bn: order.customer?.nameBn,
                                ),
                                style: Theme.of(context).textTheme.titleMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),

                  /// Branch Name
                  if (order.branch != null && order.branch!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const HugeIcon(
                              icon: HugeIcons.strokeRoundedStore01,
                              color: AppColors.grey,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                HelperFunctions.localeShopName(context, order.branch!),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),

                  /// Delivery Address
                  if (order.deliveryAddress != null && order.deliveryAddress!.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const HugeIcon(
                              icon: HugeIcons.strokeRoundedLocation01,
                              color: AppColors.grey,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                order.deliveryAddress!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(color: AppColors.grey),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),

                  const Divider(color: AppColors.borderColor, thickness: 1),
                  const SizedBox(height: 6),

                  /// Total Amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        strings.totalAmount,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      _infoTag(
                        "৳${CurrencyFormatter.format(order.totalAmount, context: context)}",
                        AppColors.primaryColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  /// Paid Amount
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        strings.paid,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      _infoTag(
                        "৳${CurrencyFormatter.format(order.paidAmount, context: context)}",
                        AppColors.success,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  /// Due Amount
                  if ((order.dueAmount ?? 0) > 0)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              strings.due,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            _infoTag(
                              "৳${CurrencyFormatter.format(order.dueAmount, context: context)}",
                              AppColors.error,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),

                  /// Items Count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        strings.items,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        CurrencyFormatter.format(order.itemsCount, context: context),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  /// Expected Delivery Date
                  if (order.expectedDeliveryDate != null &&
                      order.expectedDeliveryDate!.isNotEmpty)
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              strings.expectedDelivery,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              DateFormatters.readableDate(
                                  context, order.expectedDeliveryDate),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),

                  /// Order Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        strings.date,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        DateFormatters.readableDate(context, order.orderDate),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: AppColors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  /// Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// Pay Due Button (only if due exists)
                      if ((order.dueAmount ?? 0) > 0 && onPayDue != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: TextButton.icon(
                            onPressed: onPayDue,
                            icon: const HugeIcon(
                              icon: HugeIcons.strokeRoundedMoney01,
                              color: AppColors.error,
                              size: 18,
                            ),
                            label: Text(
                              strings.payDue,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: AppColors.error,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              backgroundColor:
                              AppColors.error.withValues(alpha: 0.1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),

                      /// View Details Button
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          backgroundColor:
                          AppColors.primaryColor.withValues(alpha: 0.1),
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
          ],
        ),
      ),
    );
  }

  Widget _infoTag(String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: color,
        ),
      ),
    );
  }

  Widget _statusTag(BuildContext context, String status) {
    final strings = AppLocalizations.of(context)!;

    Color statusColor;
    String localizedStatus;

    switch (status.toLowerCase()) {
      case 'completed':
      case 'delivered':
        statusColor = AppColors.success;
        localizedStatus = strings.statusCompleted;
        break;
      case 'pending':
        statusColor = AppColors.warning;
        localizedStatus = strings.statusPending;
        break;
      case 'processing':
        statusColor = AppColors.primaryColor;
        localizedStatus = strings.statusProcessing;
        break;
      case 'cancelled':
        statusColor = AppColors.error;
        localizedStatus = strings.statusCancelled;
        break;
      default:
        statusColor = AppColors.grey;
        localizedStatus = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        localizedStatus,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 11,
          color: statusColor,
        ),
      ),
    );
  }
}