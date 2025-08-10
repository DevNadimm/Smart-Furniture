import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/purchase/presentation/blocs/purchase_record/purchase_record_bloc.dart';
import 'package:smart_furniture/features/purchase/presentation/widgets/purchase_record_card.dart';

class PurchaseRecordPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const PurchaseRecordPage());

  const PurchaseRecordPage({super.key});

  @override
  State<PurchaseRecordPage> createState() => _PurchaseRecordPageState();
}

class _PurchaseRecordPageState extends State<PurchaseRecordPage> {
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
    context.read<PurchaseRecordBloc>().add(
      LoadPurchaseRecordEvent(
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
        title: Text(strings!.purchaseRecordTitle),
      ),
      body: Column(
        children: [
          FilterBar(
            fromDateController: _fromDateController,
            toDateController: _toDateController,
            onFilterPressed: _fetchData,
            onSelectDate: _selectDate,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<PurchaseRecordBloc, PurchaseRecordState>(
                  listener: (context, state) {
                    if (state is PurchaseRecordError) {
                      AppNotifier.showToast(state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is PurchaseRecordLoading) {
                      return const Loader();
                    }
                    if (state is PurchaseRecordLoaded) {
                      if (state.purchaseRecord.data!.isEmpty) {
                        return const EmptyStateWidget(
                          title: 'No Purchase Records Found',
                          message: 'We couldn’t find any purchase records for the selected date range. Try adjusting your filters or selecting a different time period.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.purchaseRecord.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final record = state.purchaseRecord.data?[index];
                            return PurchaseRecordCard(purchaseRecord: record,);
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
}
