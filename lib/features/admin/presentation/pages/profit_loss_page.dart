import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/admin/data/models/profit_loss_model.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/profit_loss/profit_loss_bloc.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class ProfitLossPage extends StatefulWidget {
  static Route route({required int? branchId}) =>
      MaterialPageRoute(builder: (_) => ProfitLossPage(branchId: branchId));

  final int? branchId;

  const ProfitLossPage({super.key, this.branchId});

  @override
  State<ProfitLossPage> createState() => _ProfitLossPageState();
}

class _ProfitLossPageState extends State<ProfitLossPage> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProfitLoss();
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  void _fetchProfitLoss() {
    context.read<ProfitLossBloc>().add(
      LoadProfitLossEvent(
        fromDate: _fromDateController.text,
        toDate: _toDateController.text,
        branchId: widget.branchId,
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context,
      TextEditingController controller,
      ) async {
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

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.profitLoss), // add key to l10n if needed
      ),
      body: Column(
        children: [
          FilterBar(
            startDateController: _fromDateController,
            endDateController: _toDateController,
            onApplyFilter: _fetchProfitLoss,
            onSelectDate: _selectDate,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<ProfitLossBloc, ProfitLossState>(
                  listener: (context, state) {
                    if (state is ProfitLossError) {
                      AppNotifier.showToast(state.message,
                          type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is ProfitLossLoading) {
                      return const Loader();
                    }

                    if (state is ProfitLossError) {
                      return const ErrorStateWidget(
                        title: 'Failed to Load Report',
                        message: ErrorMessages.networkError,
                      );
                    }

                    if (state is ProfitLossLoaded) {
                      final data = state.profitLoss.data;

                      if (data == null) {
                        return const EmptyStateWidget(
                          title: 'No Data Found',
                          message:
                          "No profit & loss data available for the selected period.",
                        );
                      }

                      return _ProfitLossContent(data: data);
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
}

class _ProfitLossContent extends StatelessWidget {
  final ProfitLossData data;

  const _ProfitLossContent({required this.data});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Column(
      children: [
        _SectionCard(
          title: strings.sales, // 'Sales'
          rows: [
            _RowData(strings.totalSales, data.totalSales, AppColors.primaryColor),
            _RowData(strings.salesReturn, data.totalSalesReturn, AppColors.error),
            _RowData(strings.netSales, data.netSales, AppColors.primaryColor, isBold: true),
          ],
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: strings.costs, // 'Costs'
          rows: [
            _RowData(strings.totalPurchaseCost, data.totalPurchaseCost, AppColors.grey),
          ],
        ),
        const SizedBox(height: 12),
        _SectionCard(
          title: strings.profit, // 'Profit'
          rows: [
            _RowData(strings.grossProfit, data.grossProfit, AppColors.success, isBold: true),
            _RowData(strings.totalExpenses, data.totalExpenses, AppColors.error),
            _RowData(strings.netProfit, data.netProfit,
                (data.netProfit ?? 0) >= 0 ? AppColors.success : AppColors.error,
                isBold: true),
          ],
        ),
      ],
    );
  }
}

class _RowData {
  final String label;
  final num? value;
  final Color color;
  final bool isBold;

  _RowData(this.label, this.value, this.color, {this.isBold = false});
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<_RowData> rows;

  const _SectionCard({required this.title, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Section Header
            Container(
              width: double.infinity,
              padding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              child: Text(
                title,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),

            /// Rows
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: rows.map((row) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          row.label,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                            fontWeight: row.isBold
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: row.color.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '৳${CurrencyFormatter.format(row.value, context: context)}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              color: row.color,
                              fontWeight: row.isBold
                                  ? FontWeight.w700
                                  : FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}