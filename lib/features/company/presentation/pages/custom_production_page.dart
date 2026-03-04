import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/summary_card.dart';
import 'package:smart_furniture/features/company/presentation/blocs/custom_production/custom_production_bloc.dart';
import 'package:smart_furniture/features/company/presentation/widgets/custom_production_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class CustomProductionPage extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const CustomProductionPage());

  const CustomProductionPage({super.key});

  @override
  State<CustomProductionPage> createState() => _CustomProductionPageState();
}

class _CustomProductionPageState extends State<CustomProductionPage> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCustomProductions();
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  void _fetchCustomProductions() {
    context.read<CustomProductionBloc>().add(
      LoadCustomProductionsEvent(
        startDate: _startDateController.text,
        endDate: _endDateController.text,
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
        title: Text(strings.customProductions),
      ),
      body: Column(
        children: [
          // ── Filter Bar ───────────────────────────────────
          FilterBar(
            startDateController: _startDateController,
            endDateController: _endDateController,
            onApplyFilter: _fetchCustomProductions,
            onSelectDate: _selectDate,
          ),

          // ── List ─────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocConsumer<CustomProductionBloc, CustomProductionState>(
                listener: (context, state) {
                  if (state is CustomProductionError) {
                    AppNotifier.showToast(state.message,
                        type: MessageType.error);
                  }
                },
                builder: (context, state) {
                  if (state is CustomProductionLoading) {
                    return const Loader();
                  }

                  if (state is CustomProductionError) {
                    return ErrorStateWidget(
                      title: strings.customProductionsLoadError,
                      message: ErrorMessages.networkError,
                    );
                  }

                  if (state is CustomProductionLoaded) {
                    final productions = state.customProduction.data ?? [];
                    final summary = state.customProduction.summary;

                    if (productions.isEmpty) {
                      return EmptyStateWidget(
                        title: strings.noCustomProductionsFound,
                        message: strings.noCustomProductionsMessage,
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          if (summary != null) ...[
                            const SizedBox(height: 10),
                            SummaryCard(
                              quantity: summary.totalQuantity?.toInt() ?? 0,
                              quantityLabel: strings.totalQuantity,
                              amount:
                              (summary.totalMaterialCost ?? 0).toDouble(),
                              amountLabel: strings.totalMaterialCost,
                            ),
                          ],
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: productions.length,
                            itemBuilder: (context, index) {
                              return CustomProductionCard(
                                production: productions[index],
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}