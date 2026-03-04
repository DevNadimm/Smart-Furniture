import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/stock_register_model.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/stock_register/stock_register_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/widgets/stock_movement_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class StockRegisterPage extends StatefulWidget {
  static Route route({required int? productId, required String? branchId}) => MaterialPageRoute(builder: (_) => StockRegisterPage(productId: productId, branchId: branchId),);

  final int? productId;
  final String? branchId;

  const StockRegisterPage({super.key, required this.productId, required this.branchId});

  @override
  State<StockRegisterPage> createState() => _StockRegisterPageState();
}

class _StockRegisterPageState extends State<StockRegisterPage> {
  final _startDate = TextEditingController();
  final _endDate = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchRegister();
  }

  void _fetchRegister () {
    context.read<StockRegisterBloc>().add(
      LoadStockRegisterEvent(productId: widget.productId, branchId: widget.branchId, startDate: _startDate.text, endDate: _endDate.text),
    );
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
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
      appBar: AppBar(title: Text(strings.stockRegister)),
      body: BlocConsumer<StockRegisterBloc, StockRegisterState>(
        listener: (context, state) {
          if (state is StockRegisterError) {
            AppNotifier.showToast(state.message, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is StockRegisterLoading) {
            return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Loader(),
          );
          }

          if (state is StockRegisterError) {
            return ErrorStateWidget(
              title: strings.stockRegisterLoadError,
              message: ErrorMessages.networkError,
            );
          }

          if (state is StockRegisterLoaded) {
            final product = state.stockRegister.data?.product;
            final movements = state.stockRegister.data?.movements ?? [];
            final summary = state.stockRegister.data?.summary;

            if (movements.isEmpty) {
              return EmptyStateWidget(
                title: strings.noStockRegisterFound,
                message: strings.noStockRegisterMessage,
              );
            }

            return Column(
              children: [
                FilterBar(
                  startDateController: _startDate,
                  endDateController: _endDate,
                  onSelectDate: _selectDate,
                  onApplyFilter: () => _fetchRegister(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product != null) _ProductInfoCard(product: product),
                        const SizedBox(height: 12),
                        if (summary != null) _SummaryRow(summary: summary),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const HugeIcon(
                              icon: HugeIcons.strokeRoundedExchange03,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              strings.movements,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${movements.length}',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(color: AppColors.primaryColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: movements.length,
                          itemBuilder: (context, index) => StockMovementCard(movement: movements[index]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ── Product Info Card ────────────────────────────────────────────────────────

class _ProductInfoCard extends StatelessWidget {
  final StockRegisterProduct product;

  const _ProductInfoCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

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
          children: [
            /// Header
            Container(
              width: double.infinity,
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              child: Row(
                children: [
                  const HugeIcon(
                    icon: HugeIcons.strokeRoundedPackage,
                    color: AppColors.primaryColor,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      LocalizationService.getText(
                        context,
                        en: product.name ?? strings.notAvailable,
                        bn: product.nameBn,
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: AppColors.primaryColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            /// Body
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  /// Category row
                  Row(
                    children: [
                      const HugeIcon(
                        icon: HugeIcons.strokeRoundedTag01,
                        color: AppColors.grey,
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          LocalizationService.getText(
                            context,
                            en: product.category ?? strings.notAvailable,
                            bn: product.categoryNameBn,
                          ),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: AppColors.borderColor, thickness: 1),
                  const SizedBox(height: 6),

                  /// Current Stock + Unit
                  Row(
                    children: [
                      Expanded(
                        child: _statTile(
                          context,
                          icon: HugeIcons.strokeRoundedChartHistogram,
                          label: strings.currentStock,
                          value:
                          CurrencyFormatter.format(
                            num.tryParse(product.currentStock ?? '0'),
                            context: context,
                          ),
                          color: AppColors.success,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _statTile(
                          context,
                          icon: HugeIcons.strokeRoundedCells,
                          label: strings.unit,
                          value: product.unit ?? strings.notAvailable,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statTile(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        required Color color,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          HugeIcon(icon: icon, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Summary Row ──────────────────────────────────────────────────────────────

class _SummaryRow extends StatelessWidget {
  final StockRegisterSummary summary;

  const _SummaryRow({required this.summary});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Row(
      children: [
        Expanded(
          child: _SummaryTile(
            icon: HugeIcons.strokeRoundedArrowDown01,
            label: strings.totalIn,
            value:
            CurrencyFormatter.format(summary.totalIn, context: context),
            color: AppColors.success,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _SummaryTile(
            icon: HugeIcons.strokeRoundedArrowUp01,
            label: strings.totalOut,
            value:
            CurrencyFormatter.format(summary.totalOut, context: context),
            color: AppColors.error,
          ),
        ),
      ],
    );
  }
}

class _SummaryTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _SummaryTile({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: HugeIcon(icon: icon, color: color, size: 18),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}