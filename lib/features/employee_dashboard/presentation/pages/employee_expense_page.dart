import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/expense/employee_expense_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/expense_head/expense_head_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/create_expense_page.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/edit_expense_page.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/widgets/employee_expense_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class EmployeeExpensePage extends StatefulWidget {
  static Route route({bool? isAdmin, int? branchId}) => MaterialPageRoute(builder: (_) => EmployeeExpensePage(isAdmin: isAdmin ?? false, branchId: branchId));

  final bool isAdmin;
  final int? branchId;

  const EmployeeExpensePage({super.key, required this.isAdmin, this.branchId});

  @override
  State<EmployeeExpensePage> createState() => _EmployeeExpensePageState();
}

class _EmployeeExpensePageState extends State<EmployeeExpensePage> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _headNameController = TextEditingController();
  final TextEditingController _headIdController = TextEditingController();

  Map<String, String> _headNameToId = {};
  Map<String, String> _headIdToName = {};

  @override
  void initState() {
    super.initState();
    _fetchExpenses();
    _fetchHeads();
  }

  void _fetchExpenses() {
    context.read<EmployeeExpenseBloc>().add(
      LoadEmployeeExpensesEvent(
        branchId: widget.branchId,
        fromDate: _fromDateController.text.isNotEmpty ? _fromDateController.text : null,
        toDate: _toDateController.text.isNotEmpty ? _toDateController.text : null,
        headId: _headIdController.text.isNotEmpty ? _headIdController.text : null,
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      _fromDateController.clear();
      _toDateController.clear();
      _headNameController.clear();
      _headIdController.clear();
    });
    _fetchExpenses();
  }

  void _fetchHeads() {
    context.read<ExpenseHeadBloc>().add(LoadExpenseHeadsEvent());
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void _selectHeadPicker(List<Map<String, String>> items) {
    final strings = AppLocalizations.of(context)!;

    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items.map((e) => e['name']!).toList(),
          title: strings.selectHead,
          subtitle: strings.selectHeadSubtitle,
          searchHint: strings.searchHead,
          selectedItem: _headNameController.text,
          onItemSelected: (String selectedName) {
            // Find the original ID using the displayed name
            final selectedItem = items.firstWhere(
                  (item) => item['name'] == selectedName,
              orElse: () => {'id': '', 'name': ''},
            );

            setState(() {
              _headNameController.text = selectedName;
              _headIdController.text = selectedItem['id']!;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.expenses),
      ),
      floatingActionButton: !widget.isAdmin ? FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          CreateExpensePage.route(),
        ),
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        elevation: 2,
        child: const Icon(Icons.add),
      ) : null,
      body: Column(
        children: [
          BlocBuilder<ExpenseHeadBloc, ExpenseHeadState>(
            builder: (context, state) {
              if (state is ExpenseHeadLoaded) {
                // Store both mappings
                _headIdToName = {
                  for (var c in state.expenseHeads)
                    (c.id?.toString() ?? ''): (c.head ?? '')
                };

                // Build items list with localized names
                final items = state.expenseHeads.map((e) {
                  final localizedName = LocalizationService.getText(
                    context,
                    en: e.head ?? strings.notAvailable,
                    bn: e.nameBn,
                  );
                  return {
                    'id': e.id?.toString() ?? '',
                    'name': localizedName,
                  };
                }).toList();

                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchExpenses,
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerController: _headNameController,
                  onFilterPickerTap: () => _selectHeadPicker(items),
                  filterPickerLabel: strings.head,
                );
              } else if (state is ExpenseHeadLoading) {
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: () {},
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerLabel: strings.head,
                );
              } else if (state is ExpenseHeadError) {
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchExpenses,
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerLabel: strings.head,
                );
              } else {
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchExpenses,
                  onSelectDate: _selectDate,
                );
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: BlocConsumer<EmployeeExpenseBloc, EmployeeExpenseState>(
                  listener: (context, state) {
                    if (state is EmployeeExpenseError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                    if (state is EmployeeExpenseOperationSuccess) {
                      AppNotifier.showToast(state.message, type: MessageType.success);
                      _fetchExpenses();
                    }
                  },
                  builder: (context, state) {
                    if (state is EmployeeExpenseLoading) {
                      return const Loader();
                    }

                    if (state is EmployeeExpenseError) {
                      return ErrorStateWidget(
                        title: strings.expenseLoadError,
                        message: ErrorMessages.networkError,
                      );
                    }

                    if (state is EmployeeExpenseLoaded) {
                      if (state.expenseModel.data?.isEmpty ?? true) {
                        return EmptyStateWidget(
                          title: strings.noExpensesFound,
                          message: strings.noExpensesMessage,
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.expenseModel.data!.length,
                        itemBuilder: (context, index) {
                          return EmployeeExpenseCard(
                            isAdmin: widget.isAdmin,
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
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    _headNameController.dispose();
    _headIdController.dispose();
    super.dispose();
  }
}