import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_bar_search_field.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/common/presentation/blocs/category_list/category_list_bloc.dart';
import 'package:smart_furniture/features/sales/presentation/blocs/stock/stock_bloc.dart';
import 'package:smart_furniture/features/sales/presentation/widgets/stock_card.dart';
import 'package:smart_furniture/features/sales/presentation/widgets/stock_summary_card.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class StockPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const StockPage());

  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();

  /// Map to lookup categoryId by categoryName
  Map<String, String> _categoryNameToId = {};

  bool _isSearching = false;

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
    _searchController.dispose();
    _categoryNameController.dispose();
    _categoryIdController.dispose();
    super.dispose();
  }

  void _fetchData() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<StockBloc>().add(
        LoadStockEvent(
          shop: selectedShop.name,
          fromDate: _fromDateController.text,
          toDate: _toDateController.text,
          categoryId: _categoryIdController.text,
          search: _searchController.text,
        ),
      );
    } else {
      AppNotifier.showToast(ErrorMessages.unknownError, type: MessageType.error);
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

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
      _fetchData();
    });
  }

  void _onSearchSubmitted(String value) {
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? AppBarSearchField(
                controller: _searchController,
                onSubmitted: _onSearchSubmitted,
                hintText: strings.searchStocks,
              )
            : Text(strings.stockTitle),
        actions: [
          _isSearching
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: _stopSearch,
                )
              : IconButton(
                  icon: const Icon(HugeIcons.strokeRoundedSearch02),
                  onPressed: _startSearch,
                ),
          const SizedBox(width: 8),
        ],
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
                child: BlocConsumer<StockBloc, StockState>(
                  listener: (context, state) {
                    if (state is StockError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is StockLoading) {
                      return const Loader();
                    }
                    if (state is StockError) {
                      return const ErrorStateWidget(
                        title: 'Failed to Load Stock Records',
                        message: ErrorMessages.networkError,
                      );
                    }
                    if (state is StockLoaded) {
                      final stockData = state.stock.data ?? [];

                      if (stockData.isEmpty) {
                        return const EmptyStateWidget(
                          title: 'No Stock Records Found',
                          message: "We couldn't find any stock records for the selected criteria. Try adjusting your filters or checking a different category or date range.",
                        );
                      } else {
                        return Column(
                          children: [
                            StockSummaryCard(
                              totalPurchaseAmount: state.stock.calculateData?.totalPurchasePrice ?? 0,
                              totalQuantity: state.stock.calculateData?.totalRemainingStock ?? 0,
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.stock.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                final stock = state.stock.data?[index];
                                return StockCard(stockData: stock);
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
