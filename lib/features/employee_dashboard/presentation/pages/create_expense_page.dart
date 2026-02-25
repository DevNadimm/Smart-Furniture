import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/custom_text_field.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/expense/employee_expense_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/expense_head/expense_head_bloc.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class CreateExpensePage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const CreateExpensePage());

  const CreateExpensePage({super.key});

  @override
  State<CreateExpensePage> createState() => _CreateExpensePageState();
}

class _CreateExpensePageState extends State<CreateExpensePage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _expenseHeadController = TextEditingController();
  final TextEditingController _expenseDateController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  Map<String, String> _expenseHeadNameToId = {};
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchExpenseHead();
    _expenseDateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
  }

  void _fetchExpenseHead() => context.read<ExpenseHeadBloc>().add(LoadExpenseHeadsEvent());

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _expenseDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _selectExpenseHeadPicker(List<String> items) {
    final strings = AppLocalizations.of(context)!;
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items,
          title: strings.selectExpenseHeadTitle,
          subtitle: strings.selectExpenseHeadSubtitle,
          searchHint: strings.searchExpenseHead,
          selectedItem: _expenseHeadController.text,
          onItemSelected: (String selectedName) {
            _expenseHeadController.text = selectedName;
          },
        );
      },
    );
  }

  void _createExpense() {
    final strings = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final expenseData = {
      'expense_id': _expenseHeadNameToId[_expenseHeadController.text] ?? '',
      'transaction_date': _expenseDateController.text,
      'amount': _amountController.text,
      'remarks': _remarksController.text.isEmpty ? null : _remarksController.text,
    };

    context.read<EmployeeExpenseBloc>().add(CreateEmployeeExpenseEvent(expenseData));
    print('Expense Data: $expenseData');
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return BlocConsumer<EmployeeExpenseBloc, EmployeeExpenseState>(
      listener: (context, expenseState) {
        if (expenseState is EmployeeExpenseError) {
          AppNotifier.showToast(expenseState.message, type: MessageType.error);
        } else if (expenseState is EmployeeExpenseOperationSuccess) {
          AppNotifier.showToast(strings.expenseCreatedSuccess, type: MessageType.success);
          Navigator.pop(context);
        }
      },
      builder: (context, expenseState) {
        return BlocConsumer<ExpenseHeadBloc, ExpenseHeadState>(
          listener: (context, expenseHeadState) {
            if (expenseHeadState is ExpenseHeadError) {
              AppNotifier.showToast(
                expenseHeadState.message,
                type: MessageType.error,
              );
            } else if (expenseHeadState is ExpenseHeadLoaded) {
              _expenseHeadNameToId = {
                for (final e in expenseHeadState.expenseHeads)
                  if (e.head != null && e.id != null) LocalizationService.getText(context, en: e.head ?? strings.notAvailable, bn: e.nameBn): e.id!.toString(),
              };
            }
          },
          builder: (context, expenseHeadState) {
            return Stack(
              children: [
                _content(expenseHeadState, strings),
                if (expenseHeadState is ExpenseHeadLoading || expenseState is EmployeeExpenseOperationLoading)
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: AppColors.black.withValues(alpha: 0.6),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _content(ExpenseHeadState state, AppLocalizations strings) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.createExpense),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  label: strings.expenseHead,
                  hintText: strings.selectExpenseHead,
                  controller: _expenseHeadController,
                  validationLabel: 'Expense Head',
                  readOnly: true,
                  isRequired: true,
                  onTap: state is ExpenseHeadLoaded
                      ? () => _selectExpenseHeadPicker(
                      _expenseHeadNameToId.keys.toList())
                      : null,
                  suffixIcon: const Icon(Icons.arrow_drop_down),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: strings.expenseDate,
                  hintText: strings.selectExpenseDate,
                  controller: _expenseDateController,
                  validationLabel: 'expense date',
                  isRequired: true,
                  readOnly: true,
                  onTap: _selectDate,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: strings.amount,
                  hintText: strings.enterAmount,
                  controller: _amountController,
                  validationLabel: 'Amount',
                  isRequired: true,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: strings.remarks,
                  hintText: strings.enterRemarks,
                  controller: _remarksController,
                  validationLabel: 'Remarks',
                  isRequired: false,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: _createExpense,
                      child: Text(strings.createExpense)
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _expenseHeadController.dispose();
    super.dispose();
  }
}