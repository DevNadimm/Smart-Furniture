import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/core/utils/widgets/custom_cached_image.dart';
import 'package:smart_furniture/features/custom_order/data/models/custom_order_model.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class CustomOrderDetailsPage extends StatelessWidget {
  final CustomOrderData order;

  static Route route({required CustomOrderData order}) => MaterialPageRoute(
        builder: (_) => CustomOrderDetailsPage(order: order),
      );

  const CustomOrderDetailsPage({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.customOrderDetails),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Order Header Card
              _buildOrderHeaderCard(context, strings),
              const SizedBox(height: 16),

              /// Customer Info Card
              if (order.customer != null)
                _buildCustomerInfoCard(context, strings),
              const SizedBox(height: 16),

              /// Delivery Info Card
              if (order.deliveryAddress != null &&
                  order.deliveryAddress!.isNotEmpty)
                _buildDeliveryInfoCard(context, strings),
              const SizedBox(height: 16),

              /// Order Items Section
              if (order.items != null && order.items!.isNotEmpty)
                _buildOrderItemsSection(context, strings),
              const SizedBox(height: 16),

              /// Financial Summary Card
              _buildFinancialSummaryCard(context, strings),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  /// ── Order Header Card ──────────────────────────────────────────────────────
  Widget _buildOrderHeaderCard(BuildContext context, AppLocalizations strings) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withOpacity(0.9),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.receipt_long, color: AppColors.white, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.orderNo ?? strings.notAvailable,
                      style: GoogleFonts.poppins(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (order.orderDate != null && order.orderDate!.isNotEmpty)
                      Text(
                        DateFormatters.readableDate(context, order.orderDate),
                        style: const TextStyle(
                            color: AppColors.white, fontSize: 14),
                      ),
                  ],
                ),
              ),
              _statusChip(context, order.status ?? ''),
            ],
          ),
          const SizedBox(height: 12),

          /// Branch & Dates row
          Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              if (order.branch != null && order.branch!.isNotEmpty)
                _headerInfoChip(
                  icon: HugeIcons.strokeRoundedStore01,
                  label: HelperFunctions.localeShopName(context, order.branch!),
                ),
              if (order.expectedDeliveryDate != null &&
                  order.expectedDeliveryDate!.isNotEmpty)
                _headerInfoChip(
                  icon: HugeIcons.strokeRoundedCalendar01,
                  label:
                      '${strings.expectedDelivery}: ${DateFormatters.readableDate(context, order.expectedDeliveryDate)}',
                ),
              if (order.actualDeliveryDate != null &&
                  order.actualDeliveryDate!.isNotEmpty)
                _headerInfoChip(
                  icon: HugeIcons.strokeRoundedDeliveryBox01,
                  label:
                      '${strings.actualDelivery}: ${DateFormatters.readableDate(context, order.actualDeliveryDate)}',
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _headerInfoChip({required IconData icon, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        HugeIcon(icon: icon, color: AppColors.white, size: 14),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// ── Customer Info Card ─────────────────────────────────────────────────────
  Widget _buildCustomerInfoCard(BuildContext context, AppLocalizations strings) {
    final customer = order.customer!;

    return _buildSectionCard(
      context: context,
      icon: HugeIcons.strokeRoundedUserMultiple,
      title: strings.customerInformation,
      child: Column(
        children: [
          if (customer.name != null && customer.name!.isNotEmpty)
            _buildDetailRow(
              context: context,
              icon: HugeIcons.strokeRoundedUser,
              label: strings.name,
              value: LocalizationService.getText(
                context,
                en: customer.name!,
                bn: customer.nameBn,
              ),
            ),
          if (customer.phone != null && customer.phone!.isNotEmpty)
            _buildDetailRow(
              context: context,
              icon: HugeIcons.strokeRoundedCall,
              label: strings.phone,
              value: customer.phone!,
            ),
          if (customer.email != null && customer.email!.isNotEmpty)
            _buildDetailRow(
              context: context,
              icon: HugeIcons.strokeRoundedMail01,
              label: strings.email,
              value: customer.email!,
            ),
          if (customer.address != null && customer.address!.isNotEmpty)
            _buildDetailRow(
              context: context,
              icon: HugeIcons.strokeRoundedLocation01,
              label: strings.address,
              value: customer.address!,
              maxLines: 2,
            ),
        ],
      ),
    );
  }

  /// ── Delivery Info Card ─────────────────────────────────────────────────────
  Widget _buildDeliveryInfoCard(
      BuildContext context, AppLocalizations strings) {
    return _buildSectionCard(
      context: context,
      icon: HugeIcons.strokeRoundedDeliveryBox01,
      title: strings.deliveryInformation,
      child: _buildDetailRow(
        context: context,
        icon: HugeIcons.strokeRoundedLocation01,
        label: strings.deliveryAddress,
        value: order.deliveryAddress!,
        maxLines: 3,
      ),
    );
  }

  /// ── Order Items Section ────────────────────────────────────────────────────
  Widget _buildOrderItemsSection(
      BuildContext context, AppLocalizations strings) {
    return _buildSectionCard(
      context: context,
      icon: HugeIcons.strokeRoundedPackage,
      title: strings.orderItems,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: order.items!.length,
        separatorBuilder: (_, __) => const Divider(
          color: AppColors.borderColor,
          thickness: 1,
          height: 24,
        ),
        itemBuilder: (context, index) {
          final item = order.items![index];
          return _buildOrderItemRow(context, item, strings);
        },
      ),
    );
  }

  Widget _buildOrderItemRow(BuildContext context, CustomOrderItem item, AppLocalizations strings) {
    debugPrint('Image URL: ${item.image ?? ''}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.productName ?? strings.notAvailable,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: AppColors.grey,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(8),
              child: CustomCachedImage(
                imageUrl: item.image ?? '',
                width: 80,
                height: 100,
              ),
            ),
            _buildItemDetail(
              context: context,
              label: strings.quantity,
              value: '${CurrencyFormatter.format(item.orderedQuantity ?? 0, context: context)} ${item.unit ?? ''}',
            ),
            _buildItemDetail(
              context: context,
              label: strings.unitPrice,
              value: '৳${CurrencyFormatter.format(item.unitPrice, context: context)}',
            ),
            _buildItemDetail(
              context: context,
              label: strings.total,
              value: '৳${CurrencyFormatter.format(item.totalPrice, context: context)}',
              isHighlighted: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItemDetail({
    required BuildContext context,
    required String label,
    required String value,
    bool isHighlighted = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.grey,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isHighlighted ? AppColors.primaryColor : AppColors.grey,
          ),
        ),
      ],
    );
  }

  /// ── Financial Summary Card ─────────────────────────────────────────────────
  Widget _buildFinancialSummaryCard(
      BuildContext context, AppLocalizations strings) {
    return _buildSectionCard(
      context: context,
      icon: HugeIcons.strokeRoundedWallet01,
      title: strings.paymentSummary,
      child: Column(
        children: [
          _buildSummaryRow(
            context: context,
            label: strings.subTotal,
            value:
                '৳${CurrencyFormatter.format(order.subTotal, context: context)}',
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            context: context,
            label: strings.discount,
            value:
                '৳${CurrencyFormatter.format(order.discount, context: context)}',
            valueColor: Colors.green,
          ),
          const SizedBox(height: 8),
          const Divider(color: AppColors.borderColor, thickness: 1),
          const SizedBox(height: 8),
          _buildSummaryRow(
            context: context,
            label: strings.totalAmount,
            value:
                '৳${CurrencyFormatter.format(order.totalAmount, context: context)}',
            isBold: true,
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            context: context,
            label: strings.paid,
            value:
                '৳${CurrencyFormatter.format(order.paidAmount, context: context)}',
            valueColor: Colors.green,
          ),
          if ((order.dueAmount ?? 0) > 0) ...[
            const SizedBox(height: 8),
            _buildSummaryRow(
              context: context,
              label: strings.due,
              value:
                  '৳${CurrencyFormatter.format(order.dueAmount, context: context)}',
              valueColor: Colors.red,
              isBold: true,
            ),
          ],
        ],
      ),
    );
  }

  /// ── Reusable Section Card ──────────────────────────────────────────────────
  Widget _buildSectionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          /// Section Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                HugeIcon(icon: icon, color: AppColors.primaryColor, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),

          /// Section Body
          Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ],
      ),
    );
  }

  /// ── Reusable Detail Row ────────────────────────────────────────────────────
  Widget _buildDetailRow({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String value,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HugeIcon(icon: icon, color: AppColors.primaryColor, size: 18),
          const SizedBox(width: 12),
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
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
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

  /// ── Reusable Summary Row ───────────────────────────────────────────────────
  Widget _buildSummaryRow({
    required BuildContext context,
    required String label,
    required String value,
    Color? valueColor,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w500,
            color: AppColors.grey,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: valueColor ?? AppColors.grey,
          ),
        ),
      ],
    );
  }

  /// ── Status Chip ────────────────────────────────────────────────────────────
  Widget _statusChip(BuildContext context, String status) {
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
        statusColor = AppColors.white;
        localizedStatus = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: statusColor.withValues(alpha: 0.5)),
      ),
      child: Text(
        localizedStatus,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 12,
          color: AppColors.white,
        ),
      ),
    );
  }
}
