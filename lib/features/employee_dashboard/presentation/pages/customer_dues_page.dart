import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/summary_card.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/customer_dues/customer_dues_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/widgets/customer_due_card.dart';

class CustomerDuesPage extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const CustomerDuesPage());

  const CustomerDuesPage({super.key});

  @override
  State<CustomerDuesPage> createState() => _CustomerDuesPageState();
}

class _CustomerDuesPageState extends State<CustomerDuesPage> {
  @override
  void initState() {
    super.initState();
    _fetchCustomerDues();
  }

  void _fetchCustomerDues() {
    context.read<CustomerDuesBloc>().add(LoadCustomerDuesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Dues'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchCustomerDues,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocConsumer<CustomerDuesBloc, CustomerDuesState>(
        listener: (context, state) {
          if (state is CustomerDuesError) {
            AppNotifier.showToast(state.message, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is CustomerDuesLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Loader(),
            );
          }

          if (state is CustomerDuesError) {
            return const ErrorStateWidget(
              title: 'Failed to Load Customer Dues',
              message: ErrorMessages.networkError,
            );
          }

          if (state is CustomerDuesLoaded) {
            if (state.customerDuesModel.data?.isEmpty ?? true) {
              return const EmptyStateWidget(
                title: 'No Customer Dues Found',
                message: 'Currently no customer has any pending dues.',
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SummaryCard(
                      amount: state.customerDuesModel.totalDues?.toDouble() ?? 0.0,
                      amountLabel: 'Total Dues',
                      quantity: state.customerDuesModel.totalCustomers ?? 0,
                      quantityLabel: 'Total Customers',
                    ),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.customerDuesModel.data!.length,
                    itemBuilder: (context, index) {
                      return CustomerDueCard(
                        customerDue: state.customerDuesModel.data![index],
                      );
                    },
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSummaryCard(CustomerDuesLoaded state) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSummaryItem(
            icon: Icons.people_outline,
            label: 'Total Customers',
            value: '${state.customerDuesModel.totalCustomers ?? 0}',
          ),
          Container(
            height: 40,
            width: 1,
            color: AppColors.white.withOpacity(0.3),
          ),
          _buildSummaryItem(
            icon: Icons.account_balance_wallet_outlined,
            label: 'Total Dues',
            value: '৳${state.customerDuesModel.totalDues ?? 0}',
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          color: AppColors.white,
          size: 28,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
