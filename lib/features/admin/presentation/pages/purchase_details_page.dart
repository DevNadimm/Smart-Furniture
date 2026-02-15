import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/purchase_details/purchase_details_bloc.dart';

class PurchaseDetailsPage extends StatefulWidget {
  final int purchaseId;

  static Route route({required int purchaseId}) => MaterialPageRoute(
    builder: (_) => PurchaseDetailsPage(purchaseId: purchaseId),
  );

  const PurchaseDetailsPage({
    super.key,
    required this.purchaseId,
  });

  @override
  State<PurchaseDetailsPage> createState() => _PurchaseDetailsPageState();
}

class _PurchaseDetailsPageState extends State<PurchaseDetailsPage> {
  @override
  void initState() {
    super.initState();
    _fetchPurchaseDetails();
  }

  void _fetchPurchaseDetails() {
    context.read<PurchaseDetailsBloc>().add(LoadPurchaseDetailsEvent(widget.purchaseId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchase Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchPurchaseDetails,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocConsumer<PurchaseDetailsBloc, PurchaseDetailsState>(
        listener: (context, state) {
          if (state is PurchaseDetailsError) {
            AppNotifier.showToast(state.message, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is PurchaseDetailsLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Loader(),
            );
          }

          if (state is PurchaseDetailsError) {
            return const ErrorStateWidget(
              title: 'Failed to Load Purchase Details',
              message: ErrorMessages.networkError,
            );
          }

          if (state is PurchaseDetailsLoaded) {
            final details = state.purchaseDetails;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Purchase Info Card
                    _buildPurchaseInfoCard(details),
                    const SizedBox(height: 16),

                    // Supplier Info Card
                    if (details.supplier != null)
                      _buildSupplierInfoCard(details.supplier!),
                    const SizedBox(height: 16),

                    // Received By
                    if (details.receivedBy != null && details.receivedBy!.isNotEmpty)
                      _buildInfoCard(
                        title: 'Received By',
                        content: details.receivedBy!,
                        icon: HugeIcons.strokeRoundedUser,
                      ),
                    const SizedBox(height: 16),

                    // Purchase Items
                    if (details.purchaseDetails != null && details.purchaseDetails!.isNotEmpty)
                      _buildPurchaseItemsSection(details.purchaseDetails!),
                    const SizedBox(height: 16),

                    // Summary Card
                    if (details.summary != null)
                      _buildSummaryCard(details.summary!),
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

  Widget _buildPurchaseInfoCard(details) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.receipt_long,
                color: AppColors.white,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      details.purchaseNo ?? 'N/A',
                      style: GoogleFonts.poppins(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (details.purchaseDate != null && details.purchaseDate!.isNotEmpty)
                      Text(
                        details.purchaseDate!,
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
        ],
      ),
    );
  }

  Widget _buildSupplierInfoCard(supplier) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
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
                  icon: HugeIcons.strokeRoundedUserMultiple,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Supplier Information',
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
                if (supplier.name != null && supplier.name!.isNotEmpty)
                  _buildDetailRow(
                    icon: HugeIcons.strokeRoundedUser,
                    label: 'Name',
                    value: supplier.name!,
                  ),
                if (supplier.phone != null && supplier.phone!.isNotEmpty)
                  _buildDetailRow(
                    icon: HugeIcons.strokeRoundedCall,
                    label: 'Phone',
                    value: supplier.phone!,
                  ),
                if (supplier.email != null && supplier.email!.isNotEmpty)
                  _buildDetailRow(
                    icon: HugeIcons.strokeRoundedMail01,
                    label: 'Email',
                    value: supplier.email!,
                  ),
                if (supplier.address != null && supplier.address!.isNotEmpty)
                  _buildDetailRow(
                    icon: HugeIcons.strokeRoundedLocation01,
                    label: 'Address',
                    value: supplier.address!,
                    maxLines: 2,
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
          )
        ],
      ),
      child: Row(
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

  Widget _buildPurchaseItemsSection(List<dynamic> items) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
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
                  icon: HugeIcons.strokeRoundedPackage,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Purchase Items',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
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
              final item = items[index];
              return _buildPurchaseItemCard(item);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseItemCard(dynamic item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.productName ?? 'N/A',
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
            _buildItemDetail(
              label: 'Quantity',
              value: '${item.quantity ?? 0} ${item.unit ?? ''}',
            ),
            _buildItemDetail(
              label: 'Unit Price',
              value: '৳${item.unitPrice?.toStringAsFixed(2) ?? '0.00'}',
            ),
            _buildItemDetail(
              label: 'Total',
              value: '৳${item.totalPrice?.toStringAsFixed(2) ?? '0.00'}',
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

  Widget _buildSummaryCard(summary) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
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
                  'Payment Summary',
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
                  label: 'Sub Total',
                  value: '৳${summary.subTotal?.toStringAsFixed(2) ?? '0.00'}',
                ),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  label: 'Discount',
                  value: '৳${summary.discount?.toStringAsFixed(2) ?? '0.00'}',
                  valueColor: Colors.green,
                ),
                const SizedBox(height: 8),
                const Divider(color: AppColors.borderColor, thickness: 1),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  label: 'Grand Total',
                  value: '৳${summary.grandTotal?.toStringAsFixed(2) ?? '0.00'}',
                  isBold: true,
                ),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  label: 'Paid Amount',
                  value: '৳${summary.paidAmount?.toStringAsFixed(2) ?? '0.00'}',
                  valueColor: Colors.green,
                ),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  label: 'Due Amount',
                  value: '৳${summary.dueAmount?.toStringAsFixed(2) ?? '0.00'}',
                  valueColor: Colors.red,
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

  Widget _buildDetailRow({
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
          HugeIcon(
            icon: icon,
            color: AppColors.primaryColor,
            size: 18,
          ),
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
}