import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/core/utils/widgets/summary_card.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/product_transfer/product_transfer_bloc.dart';
import 'package:smart_furniture/features/admin/presentation/pages/product_transfer_details_page.dart';
import 'package:smart_furniture/features/admin/presentation/widgets/product_transfer_card.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/finished_product_category/finished_product_category_bloc.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class ProductTransferPage extends StatefulWidget {
  static Route route({required int? branchId}) =>
      MaterialPageRoute(builder: (_) => ProductTransferPage(branchId: branchId));

  final int? branchId;

  const ProductTransferPage({super.key, this.branchId});

  @override
  State<ProductTransferPage> createState() => _ProductTransferPageState();
}

class _ProductTransferPageState extends State<ProductTransferPage> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();

  /// Map to lookup categoryId by categoryName
  Map<String, String> _categoryNameToId = {};

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchTransfers();
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    _categoryNameController.dispose();
    _categoryIdController.dispose();
    super.dispose();
  }

  void _fetchTransfers() {
    context.read<ProductTransferBloc>().add(
      LoadTransfersEvent(
        fromDate: _fromDateController.text,
        toDate: _toDateController.text,
        branchId: widget.branchId?.toString() ?? '0',
        categoryId: _categoryIdController.text,
      ),
    );
  }

  void _fetchCategories() {
    context
        .read<FinishedProductCategoryBloc>()
        .add(LoadFinishedProductCategoriesEvent());
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

  void _selectCategoryPicker(List<String> items, BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items,
          title: strings.selectCategoryTitle,
          subtitle: strings.selectCategorySubtitle,
          searchHint: strings.searchCategory,
          selectedItem: _categoryNameController.text,
          onItemSelected: (String selectedName) {
            _categoryNameController.text = selectedName;
            _categoryIdController.text =
                _categoryNameToId[selectedName] ?? '';
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.productTransfers),
      ),
      body: Column(
        children: [
          /// Filter Bar with Category
          BlocBuilder<FinishedProductCategoryBloc,
              FinishedProductCategoryState>(
            builder: (context, state) {
              if (state is FinishedProductCategoryLoaded) {
                _categoryNameToId = {
                  for (var c in state.categories)
                    (locale == 'bn'
                        ? (c.nameBn ?? '')
                        : (c.categoryName ?? '')): (c.id?.toString() ?? '')
                };
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchTransfers,
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerController: _categoryNameController,
                  onFilterPickerTap: () {
                    _selectCategoryPicker(
                      state.categories
                          .map((e) => LocalizationService.getText(
                        context,
                        en: e.categoryName ?? '',
                        bn: e.nameBn ?? '',
                      ))
                          .toList(),
                      context,
                    );
                  },
                  filterPickerLabel: strings.category,
                );
              } else if (state is FinishedProductCategoryLoading) {
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: () {},
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerLabel: strings.category,
                );
              } else if (state is FinishedProductCategoryError) {
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchTransfers,
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerLabel: strings.category,
                );
              } else {
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchTransfers,
                  onSelectDate: _selectDate,
                );
              }
            },
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<ProductTransferBloc, ProductTransferState>(
                  listener: (context, state) {
                    if (state is ProductTransferError) {
                      AppNotifier.showToast(state.message,
                          type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is ProductTransferLoading) {
                      return const Loader();
                    }

                    if (state is ProductTransferError) {
                      return ErrorStateWidget(
                        title: strings.transferLoadError,
                        message: ErrorMessages.networkError,
                      );
                    }

                    if (state is ProductTransferLoaded) {
                      final transfers = state.transfers.transfers;

                      if (transfers == null || transfers.isEmpty) {
                        return EmptyStateWidget(
                          title: strings.noTransfersFound,
                          message: strings.noTransfersMessage,
                        );
                      }

                      return Column(
                        children: [
                          SummaryCard(
                            amount: state.transfers.summary?.totalAmount
                                ?.toDouble() ??
                                0.0,
                            amountLabel: strings.totalTransferAmount,
                            quantity:
                            state.transfers.summary?.totalQuantity ?? 0,
                            quantityLabel: strings.totalTransferQuantity,
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: transfers.length,
                            itemBuilder: (context, index) {
                              return ProductTransferCard(
                                transfer: transfers[index],
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    ProductTransferDetailsPage.route(
                                      transferId: transfers[index].id!,
                                    ),
                                  );
                                },
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
