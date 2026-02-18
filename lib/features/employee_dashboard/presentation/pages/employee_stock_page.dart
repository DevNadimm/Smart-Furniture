import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/stock/employee_stock_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/widgets/employee_stock_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class EmployeeStockPage extends StatefulWidget {
  static Route route({bool? isAdmin, int? branchId}) => MaterialPageRoute(
      builder: (_) =>
          EmployeeStockPage(isAdmin: isAdmin ?? false, branchId: branchId));

  final bool isAdmin;
  final int? branchId;

  const EmployeeStockPage({super.key, required this.isAdmin, this.branchId});

  @override
  State<EmployeeStockPage> createState() => _EmployeeStockPageState();
}

class _EmployeeStockPageState extends State<EmployeeStockPage> {
  /// SEARCH CONTROLLER
  final TextEditingController _searchController = TextEditingController();

  /// DATA LISTS
  List stocks = [];
  List filteredStocks = [];

  @override
  void initState() {
    super.initState();
    _fetchStock();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchStock() {
    context
        .read<EmployeeStockBloc>()
        .add(LoadStocksEvent(branchId: widget.branchId));
  }

  /// ================= SEARCH =================

  void _onSearch(String query) {
    final q = query.toLowerCase().trim();

    setState(() {
      filteredStocks = stocks.where((stock) {
        final productName = (stock.productName ?? '').toLowerCase();

        final productNameBn = (stock.productNameBn ?? '').toLowerCase();

        final category = (stock.category ?? '').toLowerCase();

        final categoryBn = (stock.categoryNameBn ?? '').toLowerCase();

        return productName.contains(q) ||
            productNameBn.contains(q) ||
            category.contains(q) ||
            categoryBn.contains(q);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.stock),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<EmployeeStockBloc, EmployeeStockState>(
          listener: (context, state) {
            if (state is StockError) {
              AppNotifier.showToast(state.message, type: MessageType.error);
            }

            /// ✅ FIX: setState diye data set korchi
            /// tahole builder automatically rebuild hobe
            if (state is StockLoaded) {
              setState(() {
                stocks = state.stockModel.data ?? [];
                filteredStocks = stocks;
                _searchController.clear();
              });
            }
          },
          builder: (context, state) {
            if (state is StockLoading) {
              return const Loader();
            }

            if (state is StockError) {
              return ErrorStateWidget(
                title: strings.failedToLoadStock,
                message: ErrorMessages.networkError,
              );
            }

            if (state is StockLoaded) {
              if (stocks.isEmpty) {
                return EmptyStateWidget(
                  title: strings.noStockFound,
                  message: strings.noStockAvailable,
                );
              }

              return Column(
                children: [
                  /// SEARCH BAR
                  _buildSearchBar(strings),

                  /// STOCK LIST
                  Expanded(
                    child: filteredStocks.isEmpty
                        ? EmptyStateWidget(
                            title: strings.noStockFound,
                            message: strings.noStockAvailable,
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            itemCount: filteredStocks.length,
                            itemBuilder: (context, index) {
                              return EmployeeStockCard(
                                stock: filteredStocks[index],
                              );
                            },
                          ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  /// ================= SEARCH BAR =================

  Widget _buildSearchBar(AppLocalizations strings) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          _onSearch(value);
          setState(() {}); // 👈 add this
        },
        decoration: InputDecoration(
          hintText: strings.searchStock,
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _onSearch('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          isDense: true,
        ),
      ),
    );
  }
}
