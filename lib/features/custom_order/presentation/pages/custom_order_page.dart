import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/helper_functions/helper_functions.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/core/utils/widgets/summary_card.dart';
import 'package:smart_furniture/features/custom_order/presentation/blocs/custom_order/custom_order_bloc.dart';
import 'package:smart_furniture/features/custom_order/presentation/pages/custom_order_details_page.dart';
import 'package:smart_furniture/features/custom_order/presentation/pages/create_custom_order_page.dart';
import 'package:smart_furniture/features/custom_order/presentation/pages/store_due_payment_page.dart';
import 'package:smart_furniture/features/custom_order/presentation/widgets/custom_order_card.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/branch_bloc.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class CustomOrderPage extends StatefulWidget {
  static Route route({bool? isAdmin, int? branchId}) => MaterialPageRoute(
        builder: (_) => CustomOrderPage(
          isAdmin: isAdmin ?? false,
          branchId: branchId,
        ),
      );

  final bool isAdmin;
  final int? branchId;

  const CustomOrderPage({
    super.key,
    required this.isAdmin,
    this.branchId,
  });

  @override
  State<CustomOrderPage> createState() => _CustomOrderPageState();
}

class _CustomOrderPageState extends State<CustomOrderPage> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();

  final List<String> _statusOptions = [
    'Pending',
    'Delivered',
  ];

  @override
  void initState() {
    super.initState();
    _fetchBranch();
    _fetchOrders(widget.branchId);
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  void _fetchOrders(int? branchId) {
    context.read<CustomOrderBloc>().add(
          LoadCustomOrdersEvent(
            branchId: branchId,
            fromDate: _fromDateController.text,
            toDate: _toDateController.text,
            status: _statusController.text,
          ),
        );
  }

  void _fetchBranch() => context.read<BranchBloc>().add(LoadBranchesEvent());

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

  void _selectStatusPicker(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: _statusOptions,
          title: strings.selectStatusTitle,
          subtitle: strings.selectStatusSubtitle,
          searchHint: strings.searchStatus,
          selectedItem: _statusController.text,
          onItemSelected: (String selectedLocalized) {
            _statusController.text = selectedLocalized;
          },
        );
      },
    );
  }

  void _selectBranchPicker(BuildContext context, List<String> items) {
    final strings = AppLocalizations.of(context)!;

    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items,
          title: strings.selectBranch,
          subtitle: strings.selectBranchSubtitle,
          searchHint: strings.searchBranch,
          selectedItem: _branchController.text,
          onItemSelected: (String selectedBranch) {
            _branchController.text = selectedBranch;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    Map<String, int?> branchMap = {
      AppLocalizations.of(context)!.localeName == 'bn' ? 'সব' : 'All': null,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.customOrders),
        actions: [
          widget.branchId == null ?
          SizedBox(
            height: 40,
            width: 120,
            child: BlocBuilder<BranchBloc, BranchState>(
              builder: (context, state) {
                if (state is BranchLoaded) {
                  for (final branch in state.branches!.branches!) {
                    branchMap[HelperFunctions.localeShopName(context, branch.name ?? strings.notAvailable)] = branch.id;
                  }
                }
                return TextField(
                  controller: _branchController,
                  readOnly: true,
                  style: const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    labelText: strings.branch,
                    labelStyle: Theme.of(context)
                        .inputDecorationTheme
                        .labelStyle
                        ?.copyWith(fontSize: 14),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  ),
                  onTap: () {
                    if (state is BranchLoaded) {
                      final items = branchMap.keys.toList();
                      _selectBranchPicker(context, items);
                    }
                  },
                );
              },
            ),
          ) : const SizedBox.shrink(),
          const SizedBox(width: 16)
        ],
      ),
      floatingActionButton: !widget.isAdmin
          ? FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  CreateCustomOrderPage.route(branchId: widget.branchId),
                );
                _fetchOrders(
                    widget.branchId ?? branchMap[_branchController.text]);
              },
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.white,
              elevation: 2,
              child: const Icon(Icons.add),
            )
          : null,
      body: Column(
        children: [
          /// Filter Bar
          FilterBar(
            startDateController: _fromDateController,
            endDateController: _toDateController,
            onApplyFilter: () => _fetchOrders(
                widget.branchId ?? branchMap[_branchController.text]),
            onSelectDate: _selectDate,
            showFilterPicker: true,
            filterPickerController: _statusController,
            onFilterPickerTap: () => _selectStatusPicker(context),
            filterPickerLabel: strings.status,
          ),

          /// Orders List
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<CustomOrderBloc, CustomOrderState>(
                  listener: (context, state) {
                    if (state is CustomOrderError) {
                      AppNotifier.showToast(state.message,
                          type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is CustomOrderLoading) {
                      return const Loader();
                    }

                    if (state is CustomOrderError) {
                      return const ErrorStateWidget(
                        title: 'Failed to Load Orders',
                        message: ErrorMessages.networkError,
                      );
                    }

                    if (state is CustomOrderLoaded) {
                      final orders = state.orders.data ?? [];

                      if (orders.isEmpty) {
                        return EmptyStateWidget(
                          title: strings.noCustomOrdersFound,
                          message: strings.noCustomOrdersMessage,
                        );
                      }

                      final summary = state.orders.summary;

                      return Column(
                        children: [
                          /// Summary Card — pending row
                          if (summary?.pending != null &&
                              _statusController.text != 'Delivered')
                            SummaryCard(
                              amount:
                                  summary!.pending!.totalValue?.toDouble() ??
                                      0.0,
                              amountLabel: strings.pendingAmount, // add to l10n
                              quantity: summary.pending!.count ?? 0,
                              quantityLabel:
                                  strings.pendingOrders, // add to l10n
                            ),

                          /// Summary Card — delivered row
                          if (summary?.delivered != null &&
                              _statusController.text != 'Pending') ...[
                            const SizedBox(height: 8),
                            SummaryCard(
                              amount:
                                  summary!.delivered!.totalValue?.toDouble() ??
                                      0.0,
                              amountLabel: strings.deliveredAmount,
                              // add to l10n
                              quantity: summary.delivered!.count ?? 0,
                              quantityLabel:
                                  strings.deliveredOrders, // add to l10n
                            ),
                          ],

                          const SizedBox(height: 8),

                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: orders.length,
                            itemBuilder: (context, index) {
                              final order = orders[index];
                              return CustomOrderCard(
                                order: order,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    CustomOrderDetailsPage.route(order: order),
                                  );
                                },
                                onPayDue: (order.dueAmount ?? 0) > 0 &&
                                        widget.isAdmin == false
                                    ? () async {
                                        final result = await Navigator.push(
                                          context,
                                          CustomOrderDuePaymentPage.route(
                                            orderId: order.id!,
                                            orderNo: order.orderNo!,
                                            dueAmount: order.dueAmount!,
                                          ),
                                        );
                                        if (result == true)
                                          _fetchOrders(widget.branchId ??
                                              branchMap[
                                                  _branchController.text]);
                                      }
                                    : null,
                              );
                            },
                          ),
                        ],
                      );
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
