import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/admin/data/models/product_list_model.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:smart_furniture/features/admin/presentation/widgets/product_list_card.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/finished_product_category/finished_product_category_bloc.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class ProductListPage extends StatefulWidget {
  static Route route({bool? isCompany}) => MaterialPageRoute(
    builder: (context) => BlocProvider(
      create: (_) => ProductListBloc(),
      child: ProductListPage(isCompany: isCompany ?? false),
    ),
  );

  final bool isCompany;

  const ProductListPage({super.key, required this.isCompany});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();

  bool _isSearching = false;

  // category map: name -> id
  Map<String, String> _categoryNameToId = {};
  List<ProductData> _allProducts = [];

  @override
  void initState() {
    super.initState();
    _fetchCategory();
    _fetchProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _categoryNameController.dispose();
    _categoryIdController.dispose();
    super.dispose();
  }

  void _fetchCategory() {
    context.read<FinishedProductCategoryBloc>().add(
      LoadFinishedProductCategoriesEvent(),
    );
  }

  void _fetchProducts() {
    final categoryId = _categoryIdController.text.isEmpty
        ? null
        : int.tryParse(_categoryIdController.text);

    context.read<ProductListBloc>().add(
      LoadProductListEvent(categoryId: categoryId),
    );
  }

  // ── Search (client side) ───────────────────────────────

  void _startSearch() => setState(() => _isSearching = true);

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
  }

  List<ProductData> _filteredProducts() {
    final query = _searchController.text.toLowerCase().trim();
    if (query.isEmpty) return _allProducts;

    return _allProducts.where((product) {
      final name = product.itemDescription?.toLowerCase() ?? '';
      final nameBn = product.nameBn?.toLowerCase() ?? '';
      return name.contains(query) || nameBn.contains(query);
    }).toList();
  }

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
          _fetchProducts(); // server‑side category filter
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
          onChanged: (_) => setState(() {}), // local filter on each keystroke
          decoration: InputDecoration(
            hintText: strings.searchStock, // reuse "Search stock"
            border: InputBorder.none,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
        )
            : Text(strings.productListTitle),
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
          // ── Filter Bar ───────────────────────────────────
          BlocBuilder<FinishedProductCategoryBloc, FinishedProductCategoryState>(
            builder: (context, state) {
              if (state is FinishedProductCategoryLoaded) {
                _categoryNameToId = {
                  for (final c in state.categories)
                    LocalizationService.getText(
                      context,
                      en: c.categoryName ?? strings.notAvailable,
                      bn: c.nameBn,
                    ): (c.id?.toString() ?? ''),
                };
              }

              return FilterBar(
                showFilterPicker: true,
                filterPickerController: _categoryNameController,
                filterPickerLabel: strings.category,
                onFilterPickerTap:
                state is FinishedProductCategoryLoaded
                    ? () => _showCategoryPicker(strings)
                    : null,
                onApplyFilter: _fetchProducts, // same as stock page
              );
            },
          ),

          // ── Product List ───────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: BlocConsumer<ProductListBloc, ProductListState>(
                listener: (context, state) {
                  if (state is ProductListError) {
                    AppNotifier.showToast(
                      state.message,
                      type: MessageType.error,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ProductListLoading) return const Loader();

                  if (state is ProductListError) {
                    return ErrorStateWidget(
                      title: strings.failedToLoadProduct,
                      message: state.message,
                    );
                  }

                  if (state is ProductListLoaded) {
                    _allProducts = state.products;
                    final displayedProducts = _filteredProducts();

                    if (displayedProducts.isEmpty) {
                      return EmptyStateWidget(
                        title: strings.noProductFound,
                        message: strings.noProductAvailable,
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: displayedProducts.length,
                      itemBuilder: (context, index) =>
                          ProductListCard(product: displayedProducts[index], isCompany: widget.isCompany),
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