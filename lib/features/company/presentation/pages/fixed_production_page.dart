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
import 'package:smart_furniture/features/company/presentation/blocs/fixed_production/fixed_production_bloc.dart';
import 'package:smart_furniture/features/company/presentation/widgets/fixed_production_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class FixedProductionPage extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const FixedProductionPage());

  const FixedProductionPage({super.key});

  @override
  State<FixedProductionPage> createState() => _FixedProductionPageState();
}

class _FixedProductionPageState extends State<FixedProductionPage> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchFixedProductions();
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  void _fetchFixedProductions() {
    context.read<FixedProductionBloc>().add(
      LoadFixedProductionsEvent(
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
        title: Text(strings.fixedProductions),
      ),
      body: Column(
        children: [
          // ── Filter Bar ───────────────────────────────────
          FilterBar(
            startDateController: _startDateController,
            endDateController: _endDateController,
            onApplyFilter: _fetchFixedProductions,
            onSelectDate: _selectDate,
          ),

          // ── List ─────────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocConsumer<FixedProductionBloc, FixedProductionState>(
                listener: (context, state) {
                  if (state is FixedProductionError) {
                    AppNotifier.showToast(state.message,
                        type: MessageType.error);
                  }
                },
                builder: (context, state) {
                  if (state is FixedProductionLoading) {
                    return const Loader();
                  }

                  if (state is FixedProductionError) {
                    return ErrorStateWidget(
                      title: strings.fixedProductionsLoadError,
                      message: ErrorMessages.networkError,
                    );
                  }

                  if (state is FixedProductionLoaded) {
                    final productions = state.fixedProduction.data ?? [];
                    final summary = state.fixedProduction.summary;

                    if (productions.isEmpty) {
                      return EmptyStateWidget(
                        title: strings.noFixedProductionsFound,
                        message: strings.noFixedProductionsMessage,
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
                              amount: (summary.totalMaterialCost ?? 0).toDouble(),
                              amountLabel: strings.totalMaterialCost,
                            ),
                          ],
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: productions.length,
                            itemBuilder: (context, index) {
                              return FixedProductionCard(
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