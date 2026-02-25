import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
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
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/finished_product_category/finished_product_category_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/stock/employee_stock_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/widgets/employee_stock_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class EmployeeStockPage extends StatefulWidget {
  static Route route({bool? isAdmin, int? branchId}) =>
      MaterialPageRoute(builder: (_) => EmployeeStockPage(isAdmin: isAdmin ?? false, branchId: branchId));

  final bool isAdmin;
  final int? branchId;

  const EmployeeStockPage({super.key, required this.isAdmin, this.branchId});

  @override
  State<EmployeeStockPage> createState() => _EmployeeStockPageState();
}

class _EmployeeStockPageState extends State<EmployeeStockPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();

  bool _isSearching = false;

  // category map: name -> id
  Map<String, String> _categoryNameToId = {};

  @override
  void initState() {
    super.initState();
    _fetchCategory();
    _fetchStock();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _categoryNameController.dispose();
    _categoryIdController.dispose();
    super.dispose();
  }

  void _fetchStock() {
    context.read<EmployeeStockBloc>().add(
      LoadStocksEvent(
        branchId: widget.branchId,
        categoryId: _categoryIdController.text.isEmpty ? null : int.tryParse(_categoryIdController.text),
        search: _searchController.text.trim(),
      ),
    );
  }

  void _fetchCategory() {
    context.read<FinishedProductCategoryBloc>().add(LoadFinishedProductCategoriesEvent());
  }

  // ── Search ───────────────────────────────────────────────

  void _startSearch() => setState(() => _isSearching = true);

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
    _fetchStock();
  }

  void _onSearchSubmitted(String _) => _fetchStock();

  // ── Category Picker ──────────────────────────────────────

  void _showCategoryPicker(AppLocalizations strings) {
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) => SearchableBottomSheet(
        items: _categoryNameToId.keys.toList(),
        title: strings.selectCategoryTitle,
        subtitle: strings.selectCategorySubtitle,
        searchHint: strings.selectCategorySearchHint,
        selectedItem: _categoryNameController.text,
        onItemSelected: (selectedName) {
          _categoryNameController.text = selectedName;
          _categoryIdController.text = _categoryNameToId[selectedName] ?? '';
          _fetchStock();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
          controller: _searchController,
          autofocus: true,
          onSubmitted: _onSearchSubmitted,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: strings.searchStock,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4)
          ),
        )
            : Text(strings.stock),
        actions: [
          _isSearching
              ? IconButton(icon: const Icon(Icons.close), onPressed: _stopSearch)
              : IconButton(icon: const Icon(HugeIcons.strokeRoundedSearch02), onPressed: _startSearch),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // ── Filter Bar ───────────────────────────────────
          BlocBuilder<FinishedProductCategoryBloc, FinishedProductCategoryState>(
            builder: (context, state) {
              if (state is FinishedProductCategoryLoaded) {
                _categoryNameToId = {
                  for (final c in state.categories)
                    LocalizationService.getText(context, en: c.categoryName ?? strings.notAvailable, bn: c.nameBn): (c.id?.toString() ?? ''),
                };
              }

              return FilterBar(
                showFilterPicker: true,
                filterPickerController: _categoryNameController,
                filterPickerLabel: strings.category,
                onFilterPickerTap: state is FinishedProductCategoryLoaded
                    ? () => _showCategoryPicker(strings)
                    : null,
                onApplyFilter: _fetchStock,
              );
            },
          ),

          // ── Stock List ───────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocConsumer<EmployeeStockBloc, EmployeeStockState>(
                listener: (context, state) {
                  if (state is StockError) {
                    AppNotifier.showToast(state.message, type: MessageType.error);
                  }
                },
                builder: (context, state) {
                  if (state is StockLoading) return const Loader();

                  if (state is StockError) {
                    return ErrorStateWidget(
                      title: strings.failedToLoadStock,
                      message: ErrorMessages.networkError,
                    );
                  }

                  if (state is StockLoaded) {
                    final stocks = state.stockModel.data ?? [];
                    final summary = state.stockModel.summary;

                    if (stocks.isEmpty) {
                      return EmptyStateWidget(
                        title: strings.noStockFound,
                        message: strings.noStockAvailable,
                      );
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          if (summary != null) ...[
                            const SizedBox(height: 10),
                            SummaryCard(
                              quantity: summary.totalQuantity ?? 0,
                              quantityLabel: strings.totalQuantity,
                              amount: (summary.totalAmount ?? 0).toDouble(),
                              amountLabel: strings.totalAmount,
                            ),
                          ],
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: stocks.length,
                            itemBuilder: (context, index) => EmployeeStockCard(stock: stocks[index]),
                          ),
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}