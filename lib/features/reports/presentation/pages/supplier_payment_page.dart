import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/supplier_list/supplier_list_bloc.dart';
import 'package:smart_furniture/features/reports/presentation/blocs/supplier_payment/supplier_payment_bloc.dart';
import 'package:smart_furniture/features/reports/presentation/widgets/supplier_payment_card.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';

class SupplierPaymentPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const SupplierPaymentPage());

  const SupplierPaymentPage({super.key});

  @override
  State<SupplierPaymentPage> createState() => _SupplierPaymentPageState();
}

class _SupplierPaymentPageState extends State<SupplierPaymentPage> {
  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _supplierIdController = TextEditingController();
  Map<String, String> _supplierNameToId = {};

  @override
  void initState() {
    _fetchSuppliers();
    super.initState();
  }

  @override
  void dispose() {
    _supplierNameController.dispose();
    _supplierIdController.dispose();
    super.dispose();
  }

  void _fetchData() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<SupplierPaymentBloc>().add(
        LoadSupplierPaymentEvent(
          shop: selectedShop.name,
          supplierId: _supplierIdController.text,
        ),
      );
    } else {
      AppNotifier.showToast(ErrorMessages.networkError, type: MessageType.error);
    }
  }

  void _resetSupplierPayment() {
    context.read<SupplierPaymentBloc>().add(ResetSupplierPaymentEvent());
  }

  void _fetchSuppliers() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<SupplierListBloc>().add(
        LoadSupplierListEvent(
          selectedShop.name,
        ),
      );
    } else {
      AppNotifier.showToast(ErrorMessages.networkError, type: MessageType.error);
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
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.supplierPaymentsReportTitle),
        leading: IconButton(
          onPressed: () {
            _resetSupplierPayment();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
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
                    showFilterPicker: true,
                    filterPickerLabel: 'Select Supplier',
                    filterPickerController: _supplierNameController,
                    onFilterPickerTap: () => _selectSupplierPicker(state.supplierListModel.data!.map((e) => e.supplierName ?? '').toList()),
                    onApplyFilter: _fetchData,
                  );
                } else if (state is SupplierListLoading) {
                  return FilterBar(
                    showFilterPicker: true,
                    filterPickerLabel: 'Select Supplier',
                    filterPickerController: _supplierNameController,
                    onFilterPickerTap: () {},
                    onApplyFilter: () {},
                  );
                } else if (state is SupplierListError) {
                  return FilterBar(
                    showFilterPicker: true,
                    filterPickerLabel: 'Select Supplier',
                    filterPickerController: _supplierNameController,
                    onFilterPickerTap: () {},
                    onApplyFilter: _fetchData,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<SupplierPaymentBloc, SupplierPaymentState>(
                  listener: (context, state) {
                    if (state is SupplierPaymentError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is SupplierPaymentLoading) {
                      return const Loader();
                    } else if (state is SupplierPaymentInitial) {
                      return const EmptyStateWidget(
                        icon: HugeIcons.strokeRoundedDateTime,
                        title: 'Select a Supplier',
                        message: 'Choose a supplier above to view supplier payment reports.',
                      );
                    } else if (state is SupplierPaymentError) {
                      return const ErrorStateWidget(
                        title: 'Failed to Load Supplier Payment Reports',
                        message: ErrorMessages.networkError,
                      );
                    } else if (state is SupplierPaymentLoaded) {
                      final supplierPayment = state.supplierPaymentModel.data;
                      if (supplierPayment == null) {
                        return const EmptyStateWidget(
                          title: 'No Supplier Payment Reports Found',
                          message: 'We couldn’t find any supplier payment records for the selected supplier. Try choosing a different supplier.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: supplierPayment.invoices?.length ?? 0,
                          itemBuilder: (context, index) {
                            final invoice = supplierPayment.invoices?[index];
                            final supplier = supplierPayment.supplier;
                            return SupplierPaymentCard(
                              invoice: invoice,
                              supplier: supplier,
                            );
                          },
                        );
                      }
                    } else {
                      return const SizedBox.shrink();
                    }
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
