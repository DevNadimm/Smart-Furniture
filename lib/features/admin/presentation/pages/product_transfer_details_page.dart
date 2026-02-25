import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/admin/data/models/product_transfer_details_model.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/product_transfer_details/product_transfer_details_bloc.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class ProductTransferDetailsPage extends StatefulWidget {
  final int transferId;

  static Route route({required int transferId}) => MaterialPageRoute(
    builder: (_) => ProductTransferDetailsPage(transferId: transferId),
  );

  const ProductTransferDetailsPage({
    super.key,
    required this.transferId,
  });

  @override
  State<ProductTransferDetailsPage> createState() =>
      _ProductTransferDetailsPageState();
}

class _ProductTransferDetailsPageState
    extends State<ProductTransferDetailsPage> {
  @override
  void initState() {
    super.initState();
    _fetchDetails();
  }

  void _fetchDetails() {
    context
        .read<ProductTransferDetailsBloc>()
        .add(LoadTransferDetailsEvent(widget.transferId));
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.transferDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchDetails,
            tooltip: strings.refresh,
          ),
        ],
      ),
      body: BlocConsumer<ProductTransferDetailsBloc,
          ProductTransferDetailsState>(
        listener: (context, state) {
          if (state is ProductTransferDetailsError) {
            AppNotifier.showToast(state.message, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is ProductTransferDetailsLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Loader(),
            );
          }

          if (state is ProductTransferDetailsError) {
            return ErrorStateWidget(
              title: strings.transferDetailsLoadError,
              message: ErrorMessages.networkError,
            );
          }

          if (state is ProductTransferDetailsLoaded) {
            final details = state.transferDetails;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Transfer Info Header Card
                    _buildTransferInfoCard(details, strings),
                    const SizedBox(height: 16),

                    /// Route Info Card (From → To)
                    _buildRouteCard(details, strings),
                    const SizedBox(height: 16),

                    /// Company Info
                    if (details.company?.name != null &&
                        details.company!.name!.isNotEmpty)
                      _buildInfoCard(
                        title: strings.company,
                        content: details.company!.name!,
                        icon: HugeIcons.strokeRoundedBuilding04,
                      ),
                    const SizedBox(height: 16),

                    /// Created By
                    if (details.createdBy != null &&
                        details.createdBy!.isNotEmpty)
                      _buildInfoCard(
                        title: strings.createdBy,
                        content: details.createdBy!,
                        icon: HugeIcons.strokeRoundedUser,
                      ),
                    const SizedBox(height: 16),

                    /// Remarks
                    if (details.remarks != null && details.remarks!.isNotEmpty)
                      _buildInfoCard(
                        title: strings.remarks,
                        content: details.remarks!,
                        icon: HugeIcons.strokeRoundedNote,
                      ),
                    const SizedBox(height: 16),

                    /// Transfer Items
                    if (details.items != null && details.items!.isNotEmpty)
                      _buildItemsSection(details.items!, strings),
                    const SizedBox(height: 16),

                    /// Summary
                    if (details.summary != null)
                      _buildSummaryCard(details.summary!, strings),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTransferInfoCard(
      ProductTransferData details, AppLocalizations strings) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withOpacity(0.8),
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
      child: Row(
        children: [
          const Icon(
            Icons.swap_horiz_rounded,
            color: AppColors.white,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  details.transferNumber ?? strings.notAvailable,
                  style: GoogleFonts.poppins(
                    color: AppColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (details.transferDate != null &&
                    details.transferDate!.isNotEmpty)
                  Text(
                    DateFormatters.readableDate(context, details.transferDate),
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteCard(
      ProductTransferData details, AppLocalizations strings) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          /// From Location
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.fromLocation,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details.fromLocation ?? strings.notAvailable,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedArrowRight01,
              color: AppColors.primaryColor,
              size: 24,
            ),
          ),

          /// To Branch
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.toBranch,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  details.toBranch?.name ?? strings.notAvailable,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
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

  Widget _buildInfoCard({
    required String title,
    required String content,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HugeIcon(
            icon: icon,
            color: AppColors.primaryColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSection(
      List<TransferItem> items, AppLocalizations strings) {
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
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedPackage,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  strings.transferItems,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),

          /// Items List
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            itemCount: items.length,
            separatorBuilder: (context, index) => const Divider(
              color: AppColors.borderColor,
              thickness: 1,
              height: 24,
            ),
            itemBuilder: (context, index) {
              return _buildItemRow(items[index], strings);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(TransferItem item, AppLocalizations strings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Product Name & Category
        Text(
          item.productName ?? strings.notAvailable,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: AppColors.grey,
          ),
        ),
        if (item.category != null && item.category!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 8),
            child: Text(
              item.category!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.grey,
              ),
            ),
          )
        else
          const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItemDetail(
              label: strings.quantity,
              value:
              '${CurrencyFormatter.format(item.quantity, context: context)} ${item.unit ?? ''}',
            ),
            _buildItemDetail(
              label: strings.unitPrice,
              value:
              '৳${CurrencyFormatter.format(item.unitPrice, context: context)}',
            ),
            _buildItemDetail(
              label: strings.total,
              value:
              '৳${CurrencyFormatter.format(item.total, context: context)}',
              isHighlighted: true,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildItemDetail({
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

  Widget _buildSummaryCard(
      TransferDetailsSummary summary, AppLocalizations strings) {
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
                const HugeIcon(
                  icon: HugeIcons.strokeRoundedWallet01,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  strings.transferSummary,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildSummaryRow(
                  label: strings.totalQuantity,
                  value: CurrencyFormatter.format(summary.totalQuantity,
                      context: context),
                ),
                const SizedBox(height: 8),
                const Divider(color: AppColors.borderColor, thickness: 1),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  label: strings.totalAmount,
                  value:
                  '৳${CurrencyFormatter.format(summary.totalAmount, context: context)}',
                  isBold: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required String value,
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
            color: isBold ? AppColors.primaryColor : AppColors.grey,
          ),
        ),
      ],
    );
  }
}
