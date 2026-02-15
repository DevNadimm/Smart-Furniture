import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/sales/employee_sales_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/create_sales_page.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/widgets/employee_sales_card.dart';

class EmployeeSalesPage extends StatefulWidget {
  static Route route({bool? isAdmin, int? branchId}) => MaterialPageRoute(builder: (_) => EmployeeSalesPage(isAdmin: isAdmin ?? false, branchId: branchId));

  final bool isAdmin;
  final int? branchId;

  const EmployeeSalesPage({super.key, required this.isAdmin, this.branchId});

  @override
  State<EmployeeSalesPage> createState() => _EmployeeSalesPageState();
}

class _EmployeeSalesPageState extends State<EmployeeSalesPage> {
  @override
  void initState() {
    super.initState();
    _fetchSales();
  }

  void _fetchSales() {
    context.read<EmployeeSalesBloc>().add(LoadEmployeeSalesEvent(branchId: widget.branchId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales'),
      ),
      floatingActionButton: !widget.isAdmin ? FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          CreateSalesPage.route(),
        ),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        elevation: 2,
        child: const Icon(Icons.add),
      ) : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<EmployeeSalesBloc, EmployeeSalesState>(
          listener: (context, state) {
            if (state is EmployeeSalesError) {
              AppNotifier.showToast(state.message, type: MessageType.error);
            }
            if (state is EmployeeSalesOperationSuccess) {
              AppNotifier.showToast(state.message, type: MessageType.success);
            }
          },
          builder: (context, state) {
            if (state is EmployeeSalesLoading) {
              return const Loader();
            }

            if (state is EmployeeSalesError) {
              return const ErrorStateWidget(
                title: 'Failed to Load Sales',
                message: ErrorMessages.networkError,
              );
            }

            if (state is EmployeeSalesLoaded) {
              if (state.salesModel.data?.isEmpty ?? true) {
                return const EmptyStateWidget(
                  title: 'No Sales Found',
                  message: 'Currently no sales information is available.',
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: state.salesModel.data!.length,
                itemBuilder: (context, index) {
                  return EmployeeSalesCard(
                    sale: state.salesModel.data![index],
                  );
                },
              );
            }

            // Show loader when operation is in progress
            if (state is EmployeeSalesOperationLoading) {
              return const Loader();
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
