import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/daily_reports/data/models/daily_reports_model.dart';
import 'package:smart_furniture/features/daily_reports/presentation/blocs/daily_reports_bloc.dart';
import 'package:smart_furniture/features/daily_reports/presentation/widgets/additional_payment_card.dart';
import 'package:smart_furniture/features/daily_reports/presentation/widgets/cash_payment_card.dart';
import 'package:smart_furniture/features/daily_reports/presentation/widgets/employee_payment_card.dart';
import 'package:smart_furniture/features/daily_reports/presentation/widgets/report_section.dart';
import 'package:smart_furniture/features/daily_reports/presentation/widgets/sale_card.dart';
import 'package:smart_furniture/features/daily_reports/presentation/widgets/supplier_payment_card.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class DailyReportsPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const DailyReportsPage());

  const DailyReportsPage({super.key});

  @override
  State<DailyReportsPage> createState() => _DailyReportsPageState();
}

class _DailyReportsPageState extends State<DailyReportsPage> {
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  void _fetchData() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<DailyReportsBloc>().add(
        LoadDailyReportsEvent(
          selectedShop.name,
          _dateController.text,
        ),
      );
    } else {
      AppNotifier.showToast(ErrorMessages.networkError, type: MessageType.error);
    }
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
        title: Text(strings.dailyReports),
      ),
      body: Column(
        children: [
          FilterBar(
            startDateController: _dateController,
            startDateLabel: strings.selectDate,
            onSelectDate: _selectDate,
            onApplyFilter: _fetchData,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<DailyReportsBloc, DailyReportsState>(
                  listener: (context, state) {
                    if (state is DailyReportsError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is DailyReportsLoading) {
                      return const Loader();
                    }  else if (state is DailyReportsError) {
                      return const ErrorStateWidget(
                        title: 'Failed to Load Daily Reports',
                        message: ErrorMessages.networkError,
                      );
                    } else if (state is DailyReportsLoaded) {
                      final dailyReports = state.dailyReportsModel.data;
                      if (dailyReports == null || ((dailyReports.sales == null || dailyReports.sales!.isEmpty) && (dailyReports.supplierPayments == null || dailyReports.supplierPayments!.isEmpty) && (dailyReports.additionalPayments == null || dailyReports.additionalPayments!.isEmpty) && (dailyReports.cashPayments == null || dailyReports.cashPayments!.isEmpty) && (dailyReports.employeePayments == null || dailyReports.employeePayments!.isEmpty))) {
                        return const EmptyStateWidget(
                          title: 'No Daily Reports Found',
                          message: 'We couldn’t find any daily reports for the selected date. Try choosing a different date.',
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            ReportSection<Sale>(
                              title: strings.sales,
                              items: dailyReports.sales,
                              itemBuilder: (sale) => SaleCard(sale: sale),
                            ),

                            ReportSection<CashPayment>(
                              title: strings.cashPayments,
                              items: dailyReports.cashPayments,
                              itemBuilder: (cash) => CashPaymentCard(payment: cash),
                            ),

                            ReportSection<SupplierPayment>(
                              title: strings.supplierPaymentsReportTitle,
                              items: dailyReports.supplierPayments,
                              itemBuilder: (supplier) => SupplierPaymentCard(payment: supplier),
                            ),

                            ReportSection<EmployeePayment>(
                              title: strings.employeePayments,
                              items: dailyReports.employeePayments,
                              itemBuilder: (emp) => EmployeePaymentCard(employeePayment: emp),
                            ),

                            ReportSection<AdditionalPayment>(
                              title: strings.additionalPaymentsTitle,
                              items: dailyReports.additionalPayments,
                              itemBuilder: (add) => AdditionalPaymentCard(payment: add),
                            ),
                          ],
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
