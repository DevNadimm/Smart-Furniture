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
import 'package:smart_furniture/features/admin/presentation/blocs/supplier_due_details/supplier_due_details_bloc.dart';

class SupplierDueDetailsPage extends StatefulWidget {
  final int supplierId;

  static Route route({required int supplierId}) => MaterialPageRoute(
    builder: (_) => SupplierDueDetailsPage(supplierId: supplierId),
  );

  const SupplierDueDetailsPage({
    super.key,
    required this.supplierId,
  });

  @override
  State<SupplierDueDetailsPage> createState() => _SupplierDueDetailsPageState();
}

class _SupplierDueDetailsPageState extends State<SupplierDueDetailsPage> {
  @override
  void initState() {
    super.initState();
    _fetchSupplierDueDetails();
  }

  void _fetchSupplierDueDetails() {
    context.read<SupplierDueDetailsBloc>().add(LoadSupplierPurchaseDuesEvent(widget.supplierId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplier Due Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchSupplierDueDetails,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocConsumer<SupplierDueDetailsBloc, SupplierDueDetailsState>(
        listener: (context, state) {
          if (state is SupplierDueDetailsError) {
            AppNotifier.showToast(state.message, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is SupplierDueDetailsLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Loader(),
            );
          }

          if (state is SupplierDueDetailsError) {
            return const ErrorStateWidget(
              title: 'Failed to Load Supplier Due Details',
              message: ErrorMessages.networkError,
            );
          }

          if (state is SupplierDueDetailsLoaded) {
            final data = state.supplierPurchaseDueModel;
            final supplier = data.supplier;
            final purchases = data.purchases;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Supplier Info Card
                    if (supplier != null)
                      _buildSupplierInfoCard(supplier),
                    const SizedBox(height: 16),

                    // Purchase Dues List
                    if (purchases != null && purchases.isNotEmpty)
                      _buildPurchaseDuesSection(purchases)
                    else
                      const EmptyStateWidget(
                        title: 'No Purchase Dues',
                        message: 'This supplier has no outstanding purchase dues.',
                      ),
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

  Widget _buildSupplierInfoCard(supplier) {
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
                HugeIcons.strokeRoundedUserMultiple,
                color: AppColors.white,
                size: 28,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      supplier.name ?? 'N/A',
                      style: GoogleFonts.poppins(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (supplier.phone != null && supplier.phone!.isNotEmpty)
                      Text(
                        supplier.phone!,
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
          const SizedBox(height: 16),
          const Divider(color: AppColors.white, thickness: 0.5),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Due Amount',
                style: GoogleFonts.poppins(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '৳${supplier.totalDue?.toStringAsFixed(2) ?? '0.00'}',
                style: GoogleFonts.poppins(
                  color: AppColors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseDuesSection(List purchases) {
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
                  icon: HugeIcons.strokeRoundedShoppingCart01,
                  color: AppColors.primaryColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Purchase Dues (${purchases.length})',
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
            itemCount: purchases.length,
            separatorBuilder: (context, index) => const Divider(
              color: Colors.transparent,
              thickness: 1,
              height: 12,
            ),
            itemBuilder: (context, index) {
              final purchase = purchases[index];
              return _buildPurchaseDueCard(purchase);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseDueCard(dynamic purchase) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.borderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      purchase.purchaseNo ?? 'N/A',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: AppColors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (purchase.purchaseDateFormatted != null &&
                        purchase.purchaseDateFormatted!.isNotEmpty)
                      Row(
                        children: [
                          const HugeIcon(
                            icon: HugeIcons.strokeRoundedCalendar03,
                            color: AppColors.grey,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            purchase.purchaseDateFormatted!,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: purchase.dueAmount != null && purchase.dueAmount! > 0
                      ? Colors.red.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  purchase.dueAmount != null && purchase.dueAmount! > 0
                      ? 'Due'
                      : 'Paid',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: purchase.dueAmount != null && purchase.dueAmount! > 0
                        ? Colors.red
                        : Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(color: AppColors.borderColor, thickness: 1, height: 1),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildPurchaseDetail(
                label: 'Grand Total',
                value: '৳${purchase.grandTotal?.toStringAsFixed(2) ?? '0.00'}',
              ),
              _buildPurchaseDetail(
                label: 'Paid Amount',
                value: '৳${purchase.paidAmount?.toStringAsFixed(2) ?? '0.00'}',
                valueColor: Colors.green,
              ),
              _buildPurchaseDetail(
                label: 'Due Amount',
                value: '৳${purchase.dueAmount?.toStringAsFixed(2) ?? '0.00'}',
                valueColor: Colors.red,
                isHighlighted: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseDetail({
    required String label,
    required String value,
    Color? valueColor,
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
            fontSize: isHighlighted ? 15 : 14,
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.w600,
            color: valueColor ?? AppColors.grey,
          ),
        ),
      ],
    );
  }
}