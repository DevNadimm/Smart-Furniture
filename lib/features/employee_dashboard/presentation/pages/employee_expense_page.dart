import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/expense/employee_expense_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/create_expense_page.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/edit_expense_page.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/widgets/employee_expense_card.dart';

class EmployeeExpensePage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const EmployeeExpensePage());

  const EmployeeExpensePage({super.key});

  @override
  State<EmployeeExpensePage> createState() => _EmployeeExpensePageState();
}

class _EmployeeExpensePageState extends State<EmployeeExpensePage> {
  @override
  void initState() {
    super.initState();
    _fetchExpenses();
  }

  void _fetchExpenses() {
    context.read<EmployeeExpenseBloc>().add(LoadEmployeeExpensesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          CreateExpensePage.route(),
        ),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        elevation: 2,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<EmployeeExpenseBloc, EmployeeExpenseState>(
          listener: (context, state) {
            if (state is EmployeeExpenseError) {
              AppNotifier.showToast(state.message, type: MessageType.error);
            }
            if (state is EmployeeExpenseOperationSuccess) {
              AppNotifier.showToast(state.message, type: MessageType.success);
            }
          },
          builder: (context, state) {
            if (state is EmployeeExpenseLoading) {
              return const Loader();
            }

            if (state is EmployeeExpenseError) {
              return const ErrorStateWidget(
                title: 'Failed to Load Expenses',
                message: ErrorMessages.networkError,
              );
            }

            if (state is EmployeeExpenseLoaded) {
              if (state.expenseModel.data?.isEmpty ?? true) {
                return const EmptyStateWidget(
                  title: 'No Expenses Found',
                  message: 'Currently no expense information is available.',
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: state.expenseModel.data!.length,
                itemBuilder: (context, index) {
                  return EmployeeExpenseCard(
                    expense: state.expenseModel.data![index],
                    onEdit: () {
                      Navigator.push(
                        context,
                        EditExpensePage.route(
                          expense: state.expenseModel.data![index],
                        ),
                      );
                    },
                  );
                },
              );
            }

            // Show loader when operation is in progress
            if (state is EmployeeExpenseOperationLoading) {
              return const Loader();
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}