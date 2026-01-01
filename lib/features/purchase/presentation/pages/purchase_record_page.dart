import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/common/presentation/blocs/category_list/category_list_bloc.dart';
import 'package:smart_furniture/features/purchase/presentation/blocs/purchase_record/purchase_record_bloc.dart';
import 'package:smart_furniture/features/purchase/presentation/widgets/purchase_record_card.dart';
import 'package:smart_furniture/features/purchase/presentation/widgets/purchase_summary_card.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class PurchaseRecordPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const PurchaseRecordPage());

  const PurchaseRecordPage({super.key});

  @override
  State<PurchaseRecordPage> createState() => _PurchaseRecordPageState();
}

class _PurchaseRecordPageState extends State<PurchaseRecordPage> {
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
    _fetchData();
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    _categoryNameController.dispose();
    _categoryIdController.dispose();
    super.dispose();
  }

  void _fetchData() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<PurchaseRecordBloc>().add(
        LoadPurchaseRecordEvent(
          shop: selectedShop.name,
          fromDate: _fromDateController.text,
          toDate: _toDateController.text,
          categoryId: _categoryIdController.text,
        ),
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

  void _fetchCategories() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<CategoryListBloc>().add(LoadCategoryListEvent(selectedShop.name));
    } else {
      AppNotifier.showToast(ErrorMessages.unknownError, type: MessageType.error);
    }
  }

  void _selectCategoryPicker(List<String> items, AppLocalizations strings) {
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items,
          title: strings.selectCategoryTitle,
          subtitle: strings.selectCategorySubtitle,
          searchHint: strings.selectCategorySearchHint,
          selectedItem: _categoryNameController.text,
          onItemSelected: (String selectedName) {
            _categoryNameController.text = selectedName;
            _categoryIdController.text = _categoryNameToId[selectedName] ?? '';
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.purchaseRecordTitle),
      ),
      body: Column(
        children: [
          BlocBuilder<CategoryListBloc, CategoryListState>(
            builder: (context, state) {
              if (state is CategoryListLoaded) {
                _categoryNameToId = {
                  for (var c in state.categoryModel.data!)
                    (locale == 'bn' ? (c.nameBangla ?? '') : (c.name ?? '')):
                        (c.id?.toString() ?? '')
                };
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchData,
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerController: _categoryNameController,
                  onFilterPickerTap: () {
                    _selectCategoryPicker(state.categoryModel.data!.map((e) => LocalizationService.getText(context, en: e.name ?? '', bn: e.nameBangla ?? '',)).toList(), strings,);
                  },
                  filterPickerLabel: strings.category,
                );
              } else if (state is CategoryListLoading) {
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: () {},
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerLabel: strings.category,
                );
              } else if (state is CategoryListError) {
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchData,
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerLabel: strings.category,
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
                child: BlocConsumer<PurchaseRecordBloc, PurchaseRecordState>(
                  listener: (context, state) {
                    if (state is PurchaseRecordError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is PurchaseRecordLoading) {
                      return const Loader();
                    }
                    if (state is PurchaseRecordError) {
                      return const ErrorStateWidget(
                        title: 'Failed to Load Purchase Records',
                        message: ErrorMessages.networkError,
                      );
                    }
                    if (state is PurchaseRecordLoaded) {
                      if (state.purchaseRecord.data!.isEmpty) {
                        return const EmptyStateWidget(
                          title: 'No Purchase Records Found',
                          message: 'We couldn’t find any purchase records for the selected date range. Try adjusting your filters or selecting a different time period.',
                        );
                      } else {
                        return Column(
                          children: [
                            PurchaseSummaryCard(
                              totalPurchaseAmount: state.purchaseRecord.calculateData?.totalPurchaseAmount ?? 0.0,
                              totalPurchaseQuantity: state.purchaseRecord.calculateData?.totalQuantity ?? 0,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.purchaseRecord.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                final record = state.purchaseRecord.data?[index];
                                return PurchaseRecordCard(
                                  purchaseRecord: record,
                                );
                              },
                            ),
                          ],
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
