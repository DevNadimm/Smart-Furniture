import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/accounts/presentation/blocs/balance_sheet/balance_sheet_bloc.dart';
import 'package:smart_furniture/features/accounts/presentation/widgets/balance_sheet_card.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class BalanceSheetPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const BalanceSheetPage());

  const BalanceSheetPage({super.key});

  @override
  State<BalanceSheetPage> createState() => _BalanceSheetPageState();
}

class _BalanceSheetPageState extends State<BalanceSheetPage> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  void _fetchData() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<BalanceSheetBloc>().add(
        LoadBalanceSheetEvent(
          shop: selectedShop.name,
          fromDate: _fromDateController.text,
          toDate: _toDateController.text,
        ),
      );
    } else {
      AppNotifier.showToast(ErrorMessages.networkError, type: MessageType.error);
    }
  }

  void _resetBalanceSheet() {
    context.read<BalanceSheetBloc>().add(ResetBalanceSheetEvent());
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

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.balanceSheetTitle),
        leading: IconButton(
          onPressed: () {
            _resetBalanceSheet();
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
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: BlocConsumer<BalanceSheetBloc, BalanceSheetState>(
                    listener: (context, state) {
                      if (state is BalanceSheetError) {
                        AppNotifier.showToast(
                          state.message,
                          type: MessageType.error,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is BalanceSheetLoading) {
                        return const Loader();
                      } else if (state is BalanceSheetInitial) {
                        return const EmptyStateWidget(
                          icon: HugeIcons.strokeRoundedDateTime,
                          title: 'Select a Date Range',
                          message: 'Choose the "Start" and "End" dates above to view balance sheet details.',
                        );
                      } else if (state is BalanceSheetError) {
                        return const ErrorStateWidget(
                          title: 'Failed to Load Balance Sheet',
                          message: ErrorMessages.networkError,
                        );
                      } else if (state is BalanceSheetLoaded) {
                        final data = state.balanceSheetModel.data;

                        if (data == null) {
                          return const EmptyStateWidget(
                            title: 'No Balance Sheet Data',
                            message: 'No balance sheet records were found for the selected date range. Please adjust the start and end dates and try again.',
                          );
                        }
                        return BalanceSheetCard(balanceData: data);
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
