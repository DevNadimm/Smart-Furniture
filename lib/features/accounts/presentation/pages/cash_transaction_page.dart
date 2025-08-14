import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/accounts/presentation/blocs/cash_transaction/cash_transaction_bloc.dart';
import 'package:smart_furniture/features/accounts/presentation/widgets/cash_transaction_card.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';

class CashTransactionPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const CashTransactionPage());

  const CashTransactionPage({super.key});

  @override
  State<CashTransactionPage> createState() => _CashTransactionPageState();
}

class _CashTransactionPageState extends State<CashTransactionPage> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final List<String> _typeList = ['All', 'Payment', 'Recieve'];

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  void _fetchData() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<CashTransactionBloc>().add(
        LoadCashTransactionEvent(
          shop: selectedShop.name,
          type: _typeController.text,
          fromDate: _fromDateController.text,
          toDate: _toDateController.text,
        ),
      );
    } else {
      AppNotifier.showToast(ErrorMessages.networkError, type: MessageType.error);
    }
  }

  void _resetCashTransaction() {
    context.read<CashTransactionBloc>().add(ResetCashTransactionEvent());
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void _selectTypePicker(List<String> items) {
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items,
          title: 'Select Type',
          subtitle: 'Choose a type from the list',
          searchHint: 'Search Type',
          selectedItem: _typeController.text,
          onItemSelected: (String selectedName) {
            _typeController.text = selectedName;
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
        title: Text(strings.cashTransactionTitle),
        leading: IconButton(
          onPressed: () {
            _resetCashTransaction();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          FilterBar(
            startDateController: _fromDateController,
            endDateController: _toDateController,
            onApplyFilter: _fetchData,
            onSelectDate: _selectDate,
            showFilterPicker: true,
            filterPickerController: _typeController,
            onFilterPickerTap: () {
              _selectTypePicker(_typeList);
            },
            filterPickerLabel: 'Type',
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<CashTransactionBloc, CashTransactionState>(
                  listener: (context, state) {
                    if (state is CashTransactionError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is CashTransactionLoading) {
                      return const Loader();
                    } else if (state is CashTransactionInitial) {
                      return const EmptyStateWidget(
                        icon: HugeIcons.strokeRoundedMoney01,
                        title: 'Select a Type and Date Range',
                        message: 'Choose the cash transaction type and specify the "Start" and "End" dates above to view transaction details.',
                      );
                    } else if (state is CashTransactionError) {
                      return const ErrorStateWidget(
                        title: 'Failed to Load Transactions',
                        message: ErrorMessages.networkError,
                      );
                    } else if (state is CashTransactionLoaded) {
                      final cashTransactions = state.cashTransactionModel.data?.cashTransactions;
                      if (cashTransactions?.isEmpty ?? false) {
                        return const EmptyStateWidget(
                          title: 'No Cash Transactions Found',
                          message: 'We couldn’t find any cash transaction records for the selected type and date range. Try adjusting your filters or selecting a different time period.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: cashTransactions?.length ?? 0,
                          itemBuilder: (context, index) {
                            final data = cashTransactions?[index];
                            return CashTransactionCard(transaction: data);
                          },
                        );
                      }
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
