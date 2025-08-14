import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/customer_list/customer_list_bloc.dart';
import 'package:smart_furniture/features/sales/presentation/blocs/sales_return/sales_return_bloc.dart';
import 'package:smart_furniture/features/sales/presentation/widgets/sales_return_card.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';

class SalesReturnPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const SalesReturnPage());

  const SalesReturnPage({super.key});

  @override
  State<SalesReturnPage> createState() => _SalesReturnPageState();
}

class _SalesReturnPageState extends State<SalesReturnPage> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerIdController = TextEditingController();

  /// Map to lookup customerId by customerName
  Map<String, String> _customerNameToId = {};

  @override
  void initState() {
    super.initState();
    _fetchCustomers();
    _fetchData();
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    _customerNameController.dispose();
    _customerIdController.dispose();
    super.dispose();
  }

  void _fetchData() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<SalesReturnBloc>().add(
        LoadSalesReturnEvent(
          shop: selectedShop.name,
          fromDate: _fromDateController.text,
          toDate: _toDateController.text,
          customerId: _customerIdController.text,
        ),
      );
    } else {
      AppNotifier.showToast(ErrorMessages.unknownError, type: MessageType.error);
    }
  }

  void _fetchCustomers() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if(selectedShop != null) {
      context.read<CustomerListBloc>().add(LoadCustomerListEvent(selectedShop.name));
    } else {
      AppNotifier.showToast(ErrorMessages.unknownError, type: MessageType.error);
    }
  }

  Future<void> _selectDate(BuildContext context,
      TextEditingController controller) async {
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

  void _selectCustomerPicker(List<String> items) {
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items,
          title: 'Select Customer',
          subtitle: 'Choose a customer from the list',
          searchHint: 'Search Customer',
          selectedItem: _customerNameController.text,
          onItemSelected: (String selectedName) {
            _customerNameController.text = selectedName;
            _customerIdController.text = _customerNameToId[selectedName] ?? '';
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
        title: Text(strings.salesReturnTitle),
      ),
      body: Column(
        children: [
          BlocBuilder<CustomerListBloc, CustomerListState>(
            builder: (context, state) {
              if (state is CustomerListLoaded) {
                _customerNameToId = {
                  for (var c in state.customerListModel.data!)
                    c.customerName ?? '': c.id?.toString() ?? ''
                };
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchData,
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerController: _customerNameController,
                  onFilterPickerTap: () {
                    _selectCustomerPicker(state.customerListModel.data!.map((e) => e.customerName ?? '').toList());
                  },
                  filterPickerLabel: 'Customer',
                );
              } else if (state is CustomerListLoading) {
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchData,
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerLabel: 'Customer',
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<SalesReturnBloc, SalesReturnState>(
                  listener: (context, state) {
                    if (state is SalesReturnError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is SalesReturnLoading) {
                      return const Loader();
                    }
                    if (state is SalesReturnLoaded) {
                      if (state.salesReturnModel.data?.isEmpty ?? false) {
                        return const EmptyStateWidget(
                          title: 'No Sales Return Records Found',
                          message: 'We couldn’t find any sales return records for the selected date range. Try adjusting your filters or selecting a different time period.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.salesReturnModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final data = state.salesReturnModel.data?[index];
                            return SalesReturnCard(salesReturn: data);
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
