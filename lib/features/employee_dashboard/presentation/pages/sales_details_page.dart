import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/formatters/date_formatters.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/sales_details/sales_details_bloc.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class SalesDetailsPage extends StatefulWidget {
  final int saleId;

  static Route route({required int saleId}) => MaterialPageRoute(
    builder: (_) => SalesDetailsPage(saleId: saleId),
  );

  const SalesDetailsPage({
    super.key,
    required this.saleId,
  });

  @override
  State<SalesDetailsPage> createState() => _SalesDetailsPageState();
}

class _SalesDetailsPageState extends State<SalesDetailsPage> {
  @override
  void initState() {
    super.initState();
    _fetchSalesDetails();
  }

  void _fetchSalesDetails() {
    context.read<SalesDetailsBloc>().add(LoadSalesDetailsEvent(widget.saleId));
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.salesDetails),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchSalesDetails,
            tooltip: strings.refresh,
          ),
        ],
      ),
      body: BlocConsumer<SalesDetailsBloc, SalesDetailsState>(
        listener: (context, state) {
          if (state is SalesDetailsError) {
            AppNotifier.showToast(state.message, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is SalesDetailsLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Loader(),
            );
          }

          if (state is SalesDetailsError) {
            return ErrorStateWidget(
              title: strings.salesDetailsLoadError,
              message: ErrorMessages.networkError,
            );
          }

          if (state is SalesDetailsLoaded) {
            final details = state.salesDetailsModel.data;

            if (details == null) {
              return ErrorStateWidget(
                title: strings.salesDetailsLoadError,
                message: ErrorMessages.networkError,
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Sale Info Card
                    _buildSaleInfoCard(details, strings),
                    const SizedBox(height: 16),

                    /// Customer Info Card
                    if (details.customer != null)
                      _buildCustomerInfoCard(details.customer!, strings),
                    const SizedBox(height: 16),

                    /// Created By
                    if (details.createdBy != null && details.createdBy!.isNotEmpty)
                      _buildInfoCard(
                        title: strings.createdBy,
                        content: HelperFunctions.localeShopName(context, details.createdBy!),
                        icon: HugeIcons.strokeRoundedUser,
                      ),
                    const SizedBox(height: 16),

                    /// Sale Items
                    if (details.saleDetails != null && details.saleDetails!.isNotEmpty)
                      _buildSaleItemsSection(details.saleDetails!, strings),
                    const SizedBox(height: 16),

                    /// Summary Card
                    if (details.financialSummary != null)
                      _buildSummaryCard(details.financialSummary!, strings),

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

  Widget _buildSaleInfoCard(details, AppLocalizations strings) {
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
                      details.saleNo ?? strings.notAvailable,
                      style: GoogleFonts.poppins(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (details.saleDate != null && details.saleDate!.isNotEmpty)
                      Text(
                        DateFormatters.readableDate(context, details.saleDate),
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

  Widget _buildCustomerInfoCard(customer, AppLocalizations strings) {
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
                  strings.customerInformation,
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
                if (customer.name != null && customer.name!.isNotEmpty)
                  _buildDetailRow(
                    icon: HugeIcons.strokeRoundedUser,
                    label: strings.name,
                    value: customer.name!,
                  ),
                if (customer.nameBn != null && customer.nameBn!.isNotEmpty)
                  _buildDetailRow(
                    icon: HugeIcons.strokeRoundedUser,
                    label: strings.nameBangla,
                    value: customer.nameBn!,
                  ),
                if (customer.phone != null && customer.phone!.isNotEmpty)
                  _buildDetailRow(
                    icon: HugeIcons.strokeRoundedCall,
                    label: strings.phone,
                    value: customer.phone!,
                  ),
                if (customer.email != null && customer.email!.isNotEmpty)
                  _buildDetailRow(
                    icon: HugeIcons.strokeRoundedMail01,
                    label: strings.email,
                    value: customer.email!,
                  ),
                if (customer.address != null && customer.address!.isNotEmpty)
                  _buildDetailRow(
                    icon: HugeIcons.strokeRoundedLocation01,
                    label: strings.address,
                    value: customer.address!,
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

  Widget _buildSaleItemsSection(List<dynamic> items, AppLocalizations strings) {
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
                  strings.saleItems,
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
              return _buildSaleItemCard(item, strings);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSaleItemCard(dynamic item, AppLocalizations strings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocalizationService.getText(context, en: item.productName ?? strings.notAvailable, bn: item.productNameBn),
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
              label: strings.quantity,
              value: '${CurrencyFormatter.format(item.quantity ?? 0, context: context)} ${item.unit ?? ''}',
            ),
            _buildItemDetail(
              label: strings.unitPrice,
              value: '৳${CurrencyFormatter.format(num.tryParse(item.unitPrice?.toStringAsFixed(2) ?? '0.00'), context: context)}',
            ),
            _buildItemDetail(
              label: strings.total,
              value: '৳${CurrencyFormatter.format(num.tryParse(item.totalPrice?.toStringAsFixed(2) ?? '0.00'), context: context)}',
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

  Widget _buildSummaryCard(summary, AppLocalizations strings) {
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
                  strings.paymentSummary,
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
                  label: strings.subTotal,
                  value: '৳${CurrencyFormatter.format(num.tryParse(summary.subTotal?.toStringAsFixed(2) ?? '0.00'), context: context)}',
                ),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  label: strings.discount,
                  value: '৳${CurrencyFormatter.format(num.tryParse(summary.discount?.toStringAsFixed(2) ?? '0.00'), context: context)}',
                  valueColor: Colors.green,
                ),
                const SizedBox(height: 8),
                const Divider(color: AppColors.borderColor, thickness: 1),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  label: strings.grandTotal,
                  value: '৳${CurrencyFormatter.format(num.tryParse(summary.grandTotal?.toStringAsFixed(2) ?? '0.00'), context: context)}',
                  isBold: true,
                ),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  label: strings.paidAmount,
                  value: '৳${CurrencyFormatter.format(num.tryParse(summary.paidAmount?.toStringAsFixed(2) ?? '0.00'), context: context)}',
                  valueColor: Colors.green,
                ),
                const SizedBox(height: 8),
                _buildSummaryRow(
                  label: strings.dueAmount,
                  value: '৳${CurrencyFormatter.format(num.tryParse(summary.dueAmount?.toStringAsFixed(2) ?? '0.00'), context: context)}',
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