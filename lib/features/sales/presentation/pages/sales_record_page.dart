import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/sales/presentation/blocs/sales_record/sales_record_bloc.dart';
import 'package:smart_furniture/features/sales/presentation/widgets/sales_record_card.dart';

class SalesRecordPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const SalesRecordPage());

  const SalesRecordPage({super.key});

  @override
  State<SalesRecordPage> createState() => _SalesRecordPageState();
}

class _SalesRecordPageState extends State<SalesRecordPage> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  void _fetchData() {
    context.read<SalesRecordBloc>().add(
      LoadSalesRecordEvent(
        fromDate: _fromDateController.text,
        toDate: _toDateController.text,
      ),
    );
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
    final strings = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings!.salesRecordTitle),
      ),
      body: Column(
        children: [
          // Date Filter Row
          _dateFilterWidget(),

          // Data List
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<SalesRecordBloc, SalesRecordState>(
                  listener: (context, state) {
                    if (state is SalesRecordError) {
                      AppNotifier.showToast(state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is SalesRecordLoading) {
                      return const Loader();
                    }
                    if (state is SalesRecordLoaded) {
                      if (state.salesRecord!.isEmpty) {
                        return const EmptyStateWidget(
                          title: 'No Sales Records Found',
                          message: 'We couldn’t find any sales records for the selected date range. Try adjusting your filters or selecting a different time period.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.salesRecord?.length ?? 0,
                          itemBuilder: (context, index) {
                            final record = state.salesRecord?[index];
                            return SalesRecordCard(salesRecord: record);
                          },
                        );
                      }
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

  Widget _dateFilterWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _fromDateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'From Date',
              ),
              onTap: () => _selectDate(context, _fromDateController),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: _toDateController,
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'To Date',
              ),
              onTap: () => _selectDate(context, _toDateController),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: _fetchData,
            child: const Text('Filter'),
          ),
        ],
      ),
    );
  }
}
