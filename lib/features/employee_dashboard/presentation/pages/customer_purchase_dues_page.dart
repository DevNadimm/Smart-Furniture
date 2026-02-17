import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/customer_purchase_dues/customer_purchase_dues_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/widgets/customer_sale_due_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class CustomerPurchaseDuesPage extends StatefulWidget {
  final int customerId;
  final String customerName;

  static Route route({
    required int customerId,
    required String customerName,
  }) =>
      MaterialPageRoute(
        builder: (_) => CustomerPurchaseDuesPage(
          customerId: customerId,
          customerName: customerName,
        ),
      );

  const CustomerPurchaseDuesPage({
    super.key,
    required this.customerId,
    required this.customerName,
  });

  @override
  State<CustomerPurchaseDuesPage> createState() =>
      _CustomerPurchaseDuesPageState();
}

class _CustomerPurchaseDuesPageState extends State<CustomerPurchaseDuesPage> {
  @override
  void initState() {
    super.initState();
    _fetchCustomerPurchaseDues();
  }

  void _fetchCustomerPurchaseDues() {
    context.read<CustomerPurchaseDuesBloc>().add(
      LoadCustomerPurchaseDuesEvent(widget.customerId),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.customerName),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchCustomerPurchaseDues,
            tooltip: strings.refresh,
          ),
        ],
      ),
      body: BlocConsumer<CustomerPurchaseDuesBloc, CustomerPurchaseDuesState>(
        listener: (context, state) {
          if (state is CustomerPurchaseDuesError) {
            AppNotifier.showToast(state.message, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is CustomerPurchaseDuesLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Loader(),
            );
          }

          if (state is CustomerPurchaseDuesError) {
            return ErrorStateWidget(
              title: strings.failedToLoadPurchaseDues,
              message: ErrorMessages.networkError,
            );
          }

          if (state is CustomerPurchaseDuesLoaded) {
            final customer = state.customerPurchaseDueModel.customer;
            final sales = state.customerPurchaseDueModel.sales;

            if (sales?.isEmpty ?? true) {
              return EmptyStateWidget(
                title: strings.noDueSalesFound,
                message: strings.noDueSalesMessage,
              );
            }

            return Column(
              children: [
                // Customer Info Card
                if (customer != null) _buildCustomerInfoCard(customer, strings),

                // Sales List
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: sales!.length,
                    itemBuilder: (context, index) {
                      return CustomerSaleDueCard(
                        sale: sales[index],
                        customerId: widget.customerId,
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildCustomerInfoCard(customer, AppLocalizations strings) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withValues(alpha: 0.3),
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
              CircleAvatar(
                backgroundColor: AppColors.white.withValues(alpha: 0.2),
                radius: 24,
                child: Text(
                  (customer.name ?? 'C')[0].toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name ?? strings.notAvailable,
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (customer.phone != null)
                      Text(
                        customer.phone!,
                        style: TextStyle(
                          color: AppColors.white.withOpacity(0.9),
                          fontSize: 14,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    strings.totalDue,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '৳${CurrencyFormatter.format(customer.totalDue ?? 0, context: context)}',
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}