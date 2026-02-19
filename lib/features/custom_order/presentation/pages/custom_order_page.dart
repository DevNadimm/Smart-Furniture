import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/custom_order/presentation/blocs/custom_order/custom_order_bloc.dart';
import 'package:smart_furniture/features/custom_order/presentation/pages/custom_order_details_page.dart';
import 'package:smart_furniture/features/custom_order/presentation/pages/store_due_payment_page.dart';
import 'package:smart_furniture/features/custom_order/presentation/widgets/custom_order_card.dart';
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

  final List<String> _statusOptions = [
    'Pending',
    'Delivered',
  ];

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    _statusController.dispose();
    super.dispose();
  }

  void _fetchOrders() {
    context.read<CustomOrderBloc>().add(
          LoadCustomOrdersEvent(
            branchId: widget.branchId,
            fromDate: _fromDateController.text,
            toDate: _toDateController.text,
            status: _statusController.text,
          ),
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

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.customOrders),
      ),
      floatingActionButton: !widget.isAdmin
          ? FloatingActionButton(
              onPressed: () async {
                // await Navigator.push(
                //   context,
                //   CreateCustomOrderPage.route(),
                // );
                _fetchOrders();
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
            onApplyFilter: _fetchOrders,
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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                      if (state.orders.isEmpty) {
                        return EmptyStateWidget(
                          title: strings.noCustomOrdersFound,
                          message: strings.noCustomOrdersMessage,
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.orders.length,
                        itemBuilder: (context, index) {
                          final order = state.orders[index];
                          return CustomOrderCard(
                            order: order,
                            onTap: () {
                              Navigator.push(
                                context,
                                CustomOrderDetailsPage.route(order: order),
                              );
                            },
                            onPayDue: (order.dueAmount ?? 0) > 0 && widget.isAdmin == false
                                ? () async {
                                    final result = await Navigator.push(
                                      context,
                                      CustomOrderDuePaymentPage.route(
                                        orderId: order.id!,
                                        orderNo: order.orderNo!,
                                        dueAmount: order.dueAmount!,
                                      ),
                                    );
                                    if (result == true) _fetchOrders();
                                  }
                                : null,
                          );
                        },
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
