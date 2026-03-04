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
import 'package:smart_furniture/features/company/presentation/blocs/finished_product/finished_product_bloc.dart';
import 'package:smart_furniture/features/company/presentation/widgets/finished_product_card.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/finished_product_category/finished_product_category_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/stock_register_page.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class FinishedProductPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const FinishedProductPage());

  const FinishedProductPage({super.key});

  @override
  State<FinishedProductPage> createState() => _FinishedProductPageState();
}

class _FinishedProductPageState extends State<FinishedProductPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();

  bool _isSearching = false;

  Map<String, String> _categoryNameToId = {};

  @override
  void initState() {
    super.initState();
    _fetchCategory();
    _fetchFinishedProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _categoryNameController.dispose();
    _categoryIdController.dispose();
    super.dispose();
  }

  void _fetchFinishedProducts() {
    context.read<FinishedProductBloc>().add(
          LoadFinishedProductsEvent(
            _categoryIdController.text.isEmpty
                ? null
                : int.tryParse(_categoryIdController.text),
            _searchController.text.trim(),
          ),
        );
  }

  void _fetchCategory() {
    context
        .read<FinishedProductCategoryBloc>()
        .add(LoadFinishedProductCategoriesEvent());
  }

  // ── Search ───────────────────────────────────────────────

  void _startSearch() => setState(() => _isSearching = true);

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
    _fetchFinishedProducts();
  }

  void _onSearchSubmitted(String _) => _fetchFinishedProducts();

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
          _fetchFinishedProducts();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                onSubmitted: _onSearchSubmitted,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: strings.searchFinishedProducts,
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              )
            : Text(strings.finishedProducts),
        actions: [
          _isSearching
              ? IconButton(
                  icon: const Icon(Icons.close), onPressed: _stopSearch)
              : IconButton(
                  icon: const Icon(HugeIcons.strokeRoundedSearch02),
                  onPressed: _startSearch),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // ── Filter Bar ───────────────────────────────────
          BlocBuilder<FinishedProductCategoryBloc,
              FinishedProductCategoryState>(
            builder: (context, state) {
              if (state is FinishedProductCategoryLoaded) {
                _categoryNameToId = {
                  for (final c in state.categories)
                    LocalizationService.getText(context,
                        en: c.categoryName ?? strings.notAvailable,
                        bn: c.nameBn): (c.id?.toString() ?? ''),
                };
              }

              return FilterBar(
                showFilterPicker: true,
                filterPickerController: _categoryNameController,
                filterPickerLabel: strings.category,
                onFilterPickerTap: state is FinishedProductCategoryLoaded
                    ? () => _showCategoryPicker(strings)
                    : null,
                onApplyFilter: _fetchFinishedProducts,
              );
            },
          ),

          // ── Product List ─────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocConsumer<FinishedProductBloc, FinishedProductState>(
                listener: (context, state) {
                  if (state is FinishedProductError) {
                    AppNotifier.showToast(state.message,
                        type: MessageType.error);
                  }
                },
                builder: (context, state) {
                  if (state is FinishedProductLoading) return const Loader();

                  if (state is FinishedProductError) {
                    return ErrorStateWidget(
                      title: strings.finishedProductsLoadError,
                      message: ErrorMessages.networkError,
                    );
                  }

                  if (state is FinishedProductLoaded) {
                    final products = state.finishedProductModel.data ?? [];
                    final summary = state.finishedProductModel.summary;

                    if (products.isEmpty) {
                      EmptyStateWidget(
                        title: strings.noFinishedProductsFound,
                        message: strings.noFinishedProductsMessage,
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
                            itemCount: products.length,
                            itemBuilder: (context, index) =>
                                FinishedProductCard(
                              finishedProduct: products[index], onTap: () => Navigator.push(context, StockRegisterPage.route(productId: products[index].productId, branchId: '')),
                            ),
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
