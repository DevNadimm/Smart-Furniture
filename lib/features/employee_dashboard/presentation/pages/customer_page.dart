import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/customer/customer_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/create_customer_page.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/edit_customer_page.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/widgets/customer_card.dart';

class CustomerPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const CustomerPage());

  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  @override
  void initState() {
    super.initState();
    _fetchCustomers();
  }

  void _fetchCustomers() {
    context.read<CustomerBloc>().add(LoadCustomersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          CreateCustomerPage.route(),
        ),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        elevation: 2,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<CustomerBloc, CustomerState>(
          listener: (context, state) {
            if (state is CustomerError) {
              AppNotifier.showToast(state.message, type: MessageType.error);
            }
            if (state is CustomerOperationSuccess) {
              AppNotifier.showToast(state.message, type: MessageType.success);
            }
          },
          builder: (context, state) {
            if (state is CustomerLoading) {
              return const Loader();
            }

            if (state is CustomerError) {
              return const ErrorStateWidget(
                title: 'Failed to Load Customers',
                message: ErrorMessages.networkError,
              );
            }

            if (state is CustomerLoaded) {
              if (state.customerModel.data?.isEmpty ?? true) {
                return const EmptyStateWidget(
                  title: 'No Customers Found',
                  message: 'Currently no customer information is available.',
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: state.customerModel.data!.length,
                itemBuilder: (context, index) {
                  return CustomerCard(
                    customer: state.customerModel.data![index],
                    onEdit: () {
                      Navigator.push(
                        context,
                        EditCustomerPage.route(
                          customer: state.customerModel.data![index],
                        ),
                      );
                    },
                  );
                },
              );
            }

            // Show loader when operation is in progress
            if (state is CustomerOperationLoading) {
              return const Loader();
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}