import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/product_ledger/product_ledger_bloc.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:smart_furniture/features/administration/presentation/widgets/product_ledger_card.dart';

class ProductLedgerPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const ProductLedgerPage());

  const ProductLedgerPage({super.key});

  @override
  State<ProductLedgerPage> createState() => _ProductLedgerPageState();
}

class _ProductLedgerPageState extends State<ProductLedgerPage> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productIdController = TextEditingController();

  /// Map to lookup productId by productName
  Map<String, String> _productNameToId = {};

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    _productNameController.dispose();
    _productIdController.dispose();
    super.dispose();
  }

  void _fetchData() {
    context.read<ProductLedgerBloc>().add(
      LoadProductLedgerEvent(
        fromDate: _fromDateController.text,
        toDate: _toDateController.text,
        productId: _productIdController.text,
      ),
    );
  }

  void _fetchProducts() {
    context.read<ProductListBloc>().add(LoadProductListEvent(''));
  }

  void _resetProductLedger() {
    context.read<ProductLedgerBloc>().add(ResetProductLedgerEvent());
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

  void _selectProductPicker(List<String> items) {
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items,
          title: 'Select Product',
          subtitle: 'Choose a product from the list',
          searchHint: 'Search Product',
          selectedItem: _productNameController.text,
          onItemSelected: (String selectedName) {
            _productNameController.text = selectedName;
            _productIdController.text = _productNameToId[selectedName] ?? '';
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
        title: Text(strings.productLedgerTitle),
        leading: IconButton(
          onPressed: () {
            _resetProductLedger();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
              if (state is ProductListLoaded) {
                _productNameToId = {
                  for (var p in state.productListModel.data!)
                    p.productName ?? '': p.id?.toString() ?? ''
                };
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchData,
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerController: _productNameController,
                  onFilterPickerTap: () {
                    _selectProductPicker(state.productListModel.data!.map((e) => e.productName ?? '').toList());
                  },
                  filterPickerLabel: 'Product',
                );
              } else if (state is ProductListLoading) {
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchData,
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerLabel: 'Product',
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                child: BlocConsumer<ProductLedgerBloc, ProductLedgerState>(
                  listener: (context, state) {
                    if (state is ProductLedgerError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is ProductLedgerLoading) {
                      return const Loader();
                    }
                    if (state is ProductLedgerInitial) {
                      return const EmptyStateWidget(
                        icon: HugeIcons.strokeRoundedDeliveryBox01,
                        title: 'Select a Product and Date Range',
                        message: 'Choose a product and specify the "Start" and "End" dates above to view its ledger details.',
                      );
                    }
                    if (state is ProductLedgerLoaded) {
                      if (state.productLedgerModel.data?.isEmpty ?? false) {
                        return const EmptyStateWidget(
                          title: 'No Product Ledger Records Found',
                          message: 'We couldn’t find any product ledger records for the selected date range. Try adjusting your filters or selecting a different time period.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.productLedgerModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final data = state.productLedgerModel.data?[index];
                            return ProductLedgerCard(ledgerData: data);
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
