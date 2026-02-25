import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/employee_sales_details_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/sale_item_model.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class ProductSelectionPage extends StatefulWidget {
  final List<EmployeeProduct> products;
  final List<SaleItem> selectedItems;
  final bool isBranchUser;

  const ProductSelectionPage({
    super.key,
    required this.products,
    required this.selectedItems,
    required this.isBranchUser,
  });

  static Route<List<SaleItem>> route({
    required List<EmployeeProduct> products,
    required List<SaleItem> selectedItems,
    required bool isBranchUser,
  }) {
    return MaterialPageRoute<List<SaleItem>>(
      builder: (_) => ProductSelectionPage(
        products: products,
        selectedItems: selectedItems,
        isBranchUser: isBranchUser,
      ),
    );
  }

  @override
  State<ProductSelectionPage> createState() => _ProductSelectionPageState();
}

class _ProductSelectionPageState extends State<ProductSelectionPage> {
  late List<SaleItem> _selectedItems;
  String _searchQuery = '';
  int? _selectedCategoryId;

  final Map<int, TextEditingController> _priceControllers = {};

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.selectedItems);

    for (final item in _selectedItems) {
      _priceControllers[item.productId] = TextEditingController(
        text: item.unitPrice.toStringAsFixed(2),
      );
    }
  }

  @override
  void dispose() {
    for (final controller in _priceControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  bool _isSelected(int productId) {
    return _selectedItems.any((item) => item.productId == productId);
  }

  SaleItem? _getSelectedItem(int productId) {
    try {
      return _selectedItems.firstWhere((item) => item.productId == productId);
    } catch (e) {
      return null;
    }
  }

  void _toggleSelection(EmployeeProduct product) {
    setState(() {
      if (_isSelected(product.id!)) {
        _selectedItems.removeWhere((item) => item.productId == product.id!);
        _priceControllers[product.id!]?.dispose();
        _priceControllers.remove(product.id!);
      } else {
        final defaultPrice = double.tryParse(product.salesRate ?? '0') ?? 0;
        _selectedItems.add(
          SaleItem(
            productId: product.id!,
            productName: product.productName ?? '',
            quantity: 1,
            unitPrice: defaultPrice,
            unitName: product.unit?.unitName,
            image: product.fullImageUrl,
          ),
        );
        _priceControllers[product.id!] = TextEditingController(
          text: defaultPrice.toStringAsFixed(2),
        );
      }
    });
  }

  void _updateQuantity(int productId, int quantity) {
    setState(() {
      final index =
      _selectedItems.indexWhere((item) => item.productId == productId);
      if (index != -1) {
        _selectedItems[index] =
            _selectedItems[index].copyWith(quantity: quantity);
      }
    });
  }

  void _updatePrice(int productId, String value) {
    final newPrice = double.tryParse(value);
    if (newPrice == null) return;

    final index =
    _selectedItems.indexWhere((item) => item.productId == productId);
    if (index != -1) {
      _selectedItems[index] =
          _selectedItems[index].copyWith(unitPrice: newPrice);
    }
  }

  double _getStock(EmployeeProduct product) {
    if (widget.isBranchUser) {
      return double.tryParse(product.branchStock?.toString() ?? '0') ?? 0;
    } else {
      return double.tryParse(product.companyStock ?? '0') ?? 0;
    }
  }

  List<EmployeeProduct> get _filteredProducts {
    return widget.products.where((product) {
      final matchesSearch = _searchQuery.isEmpty ||
          (product.productName
              ?.toLowerCase()
              .contains(_searchQuery.toLowerCase()) ??
              false) ||
          (product.nameBn?.contains(_searchQuery) ?? false);
      final matchesCategory = _selectedCategoryId == null ||
          (product.category?.id == _selectedCategoryId);
      final hasStock = _getStock(product) > 0;

      return matchesSearch && matchesCategory && hasStock;
    }).toList();
  }

  List<EmployeeCategory> get _availableCategories {
    final categoryMap = <int, EmployeeCategory>{};

    for (var product in widget.products) {
      if (_getStock(product) > 0 && product.category != null) {
        categoryMap[product.category!.id!] = product.category!;
      }
    }

    return categoryMap.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          strings.selectProducts,
        ),
        actions: [
          if (_selectedItems.isNotEmpty)
            Center(
              child: Container(
                margin: const EdgeInsets.only(right: 16),
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${_selectedItems.length} ${strings.selected}',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: strings.searchProducts,
                  hintStyle: GoogleFonts.inter(
                    fontSize: 16,
                    color: const Color(0xFF9E9E9E),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF9E9E9E),
                    size: 24,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
          ),

          if (_availableCategories.isNotEmpty)
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              child: SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildCategoryChip(
                      label: strings.all,
                      isSelected: _selectedCategoryId == null,
                      onTap: () {
                        setState(() {
                          _selectedCategoryId = null;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    ..._availableCategories.map((category) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _buildCategoryChip(
                          label: category.categoryName ??
                              'Category ${category.id}',
                          isSelected: _selectedCategoryId == category.id,
                          onTap: () {
                            setState(() {
                              _selectedCategoryId =
                              _selectedCategoryId == category.id
                                  ? null
                                  : category.id;
                            });
                          },
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          Expanded(
            child: _filteredProducts.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    strings.noProductsAvailable,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF9E9E9E),
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              itemCount: _filteredProducts.length,
              itemBuilder: (context, index) {
                final product = _filteredProducts[index];
                final isSelected = _isSelected(product.id!);
                final selectedItem = _getSelectedItem(product.id!);
                final stock = _getStock(product);

                return _buildProductCard(
                  product: product,
                  isSelected: isSelected,
                  selectedItem: selectedItem,
                  stock: stock,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _selectedItems.isNotEmpty
          ? Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context, _selectedItems);
              },
              child: Text(strings.addItems(_selectedItems.length)),
            ),
          ),
        ),
      )
          : null,
    );
  }

  Widget _buildCategoryChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : const Color(0xFF424242),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard({
    required EmployeeProduct product,
    required bool isSelected,
    required SaleItem? selectedItem,
    required double stock,
  }) {
    final strings = AppLocalizations.of(context)!;
    final priceController = _priceControllers[product.id!];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color:
          isSelected ? AppColors.primaryColor : const Color(0xFFE0E0E0),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: () => _toggleSelection(product),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Checkbox
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryColor
                            : const Color(0xFFBDBDBD),
                        width: 2,
                      ),
                    ),
                    child: isSelected
                        ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                        : null,
                  ),
                  const SizedBox(width: 14),

                  // Product Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.productName ?? '',
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1A1A1A),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            if (!isSelected) ...[
                              Text(
                                '৳${product.salesRate}',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              if (product.unit?.unitName != null) ...[
                                Text(
                                  ' / ${product.unit!.unitName}',
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: const Color(0xFF757575),
                                  ),
                                ),
                              ],
                            ],
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: stock < 10
                                    ? const Color(0xFFFFEBEE)
                                    : const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                '${strings.stock}: ${stock.toStringAsFixed(0)}',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: stock < 10
                                      ? const Color(0xFFD32F2F)
                                      : const Color(0xFF757575),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Quantity Controls (only when selected)
                  if (isSelected && selectedItem != null) ...[
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: selectedItem.quantity > 1
                                ? () => _updateQuantity(
                                product.id!, selectedItem.quantity - 1)
                                : null,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.remove,
                                size: 18,
                                color: selectedItem.quantity > 1
                                    ? const Color(0xFF1A1A1A)
                                    : const Color(0xFFBDBDBD),
                              ),
                            ),
                          ),
                          Container(
                            constraints: const BoxConstraints(minWidth: 32),
                            alignment: Alignment.center,
                            child: Text(
                              '${selectedItem.quantity}',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A1A1A),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: selectedItem.quantity < stock
                                ? () => _updateQuantity(
                                product.id!, selectedItem.quantity + 1)
                                : null,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.add,
                                size: 18,
                                color: selectedItem.quantity < stock
                                    ? const Color(0xFF1A1A1A)
                                    : const Color(0xFFBDBDBD),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),

              // ── Editable Price Row (only when selected) ──────────────────
              if (isSelected && selectedItem != null && priceController != null) ...[
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      const SizedBox(width: 36),
                      Text(
                        '${strings.price}:',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF757575),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Container(
                          height: 38,
                          constraints: const BoxConstraints(maxWidth: 140),
                          child: Center(
                            child: TextField(
                              controller: priceController,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                              ],
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A1A1A),
                              ),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(left: 4),
                              ),
                              onChanged: (val) => _updatePrice(product.id!, val),
                              onTapOutside: (_) => FocusScope.of(context).unfocus(),
                            ),
                          ),
                        ),
                      ),
                      if (product.unit?.unitName != null) ...[
                        const SizedBox(width: 4),
                        Text(
                          '/ ${product.unit!.unitName}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF757575),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}