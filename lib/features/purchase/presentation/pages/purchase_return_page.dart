import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/purchase/presentation/blocs/purchase_return/purchase_return_bloc.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/supplier_list/supplier_list_bloc.dart';
import 'package:smart_furniture/features/purchase/presentation/widgets/purchase_return_card.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';

class PurchaseReturnPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const PurchaseReturnPage());

  const PurchaseReturnPage({super.key});

  @override
  State<PurchaseReturnPage> createState() => _PurchaseReturnPageState();
}

class _PurchaseReturnPageState extends State<PurchaseReturnPage> {
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _supplierIdController = TextEditingController();

  /// Map to lookup supplierId by supplierName
  Map<String, String> _supplierNameToId = {};

  @override
  void initState() {
    super.initState();
    _fetchSuppliers();
    _fetchData();
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _supplierNameController.dispose();
    _supplierIdController.dispose();
    super.dispose();
  }

  void _fetchData() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<PurchaseReturnBloc>().add(
        LoadPurchaseReturnEvent(
          shop: selectedShop.name,
          fromDate: _startDateController.text,
          toDate: _endDateController.text,
          supplierId: _supplierIdController.text,
        ),
      );
    } else {
      AppNotifier.showToast(ErrorMessages.unknownError, type: MessageType.error);
    }
  }

  void _fetchSuppliers() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<SupplierListBloc>().add(
        LoadSupplierListEvent(selectedShop.name),
      );
    } else {
      AppNotifier.showToast(ErrorMessages.unknownError, type: MessageType.error);
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

  void _selectSupplierPicker(List<String> items) {
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items,
          title: 'Select Supplier',
          subtitle: 'Choose a supplier from the list',
          searchHint: 'Search Supplier',
          selectedItem: _supplierNameController.text,
          onItemSelected: (String selectedName) {
            _supplierNameController.text = selectedName;
            _supplierIdController.text = _supplierNameToId[selectedName] ?? '';
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings!.purchaseReturnTitle),
      ),
      body: Column(
        children: [
          BlocBuilder<SupplierListBloc, SupplierListState>(
            builder: (context, state) {
               if (state is SupplierListLoaded) {
                _supplierNameToId = {
                  for (var s in state.supplierListModel.data!)
                    s.supplierName ?? '': s.id?.toString() ?? ''
                };
                return FilterBar(
                  startDateController: _startDateController,
                  endDateController: _endDateController,
                  onApplyFilter: _fetchData,
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerController: _supplierNameController,
                  onFilterPickerTap: () {
                    _selectSupplierPicker(state.supplierListModel.data!.map((e) => e.supplierName ?? '').toList());
                  },
                  filterPickerLabel: 'Supplier',
                );
              } else if (state is SupplierListLoading) {
                 return FilterBar(
                   startDateController: _startDateController,
                   endDateController: _endDateController,
                   onApplyFilter: () {},
                   onSelectDate: _selectDate,
                   showFilterPicker: true,
                   filterPickerLabel: 'Supplier',
                 );
               } else if (state is SupplierListError) {
                 return FilterBar(
                   startDateController: _startDateController,
                   endDateController: _endDateController,
                   onApplyFilter: () {},
                   onSelectDate: _selectDate,
                   showFilterPicker: true,
                   filterPickerLabel: 'Supplier',
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
                child: BlocConsumer<PurchaseReturnBloc, PurchaseReturnState>(
                  listener: (context, state) {
                    if (state is PurchaseReturnError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is PurchaseReturnLoading) {
                      return const Loader();
                    }
                    if (state is PurchaseReturnError) {
                      return const ErrorStateWidget(
                        title: 'Failed to Load Purchase Return Records',
                        message: ErrorMessages.networkError,
                      );
                    }
                    if (state is PurchaseReturnLoaded) {
                      if (state.purchaseReturnModel.data!.isEmpty) {
                        return const EmptyStateWidget(
                          title: 'No Purchase Return Records Found',
                          message: 'We couldn’t find any purchase return records for the selected date range. Try adjusting your filters or selecting a different time period.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.purchaseReturnModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final data = state.purchaseReturnModel.data?[index];
                            return PurchaseReturnCard(returnData: data);
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
