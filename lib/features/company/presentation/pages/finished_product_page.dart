import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/company/presentation/blocs/finished_product/finished_product_bloc.dart';
import 'package:smart_furniture/features/company/presentation/widgets/finished_product_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class FinishedProductPage extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const FinishedProductPage());

  const FinishedProductPage({super.key});

  @override
  State<FinishedProductPage> createState() => _FinishedProductPageState();
}

class _FinishedProductPageState extends State<FinishedProductPage> {
  /// SEARCH CONTROLLER
  final TextEditingController _searchController = TextEditingController();

  /// DATA LIST
  List finishedProducts = [];
  List filteredProducts = [];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchFinishedProducts();
  }

  void _fetchFinishedProducts() {
    context.read<FinishedProductBloc>().add(LoadFinishedProductsEvent());
  }

  void _onSearch(String query) {
    final q = query.toLowerCase().trim();

    setState(() {
      filteredProducts = finishedProducts.where((product) {
        final productName = (product.productName ?? '').toLowerCase();

        final productNameBn = (product.productNameBn ?? '').toLowerCase();

        final category = (product.category ?? '').toLowerCase();

        final categoryBn = (product.categoryNameBn ?? '').toLowerCase();

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
        title: Text(strings.finishedProducts),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<FinishedProductBloc, FinishedProductState>(
          listener: (context, state) {
            if (state is FinishedProductError) {
              AppNotifier.showToast(state.message, type: MessageType.error);
            }

            if (state is FinishedProductLoaded) {
              setState(() {
                finishedProducts = state.finishedProducts;
                filteredProducts = finishedProducts;
                _searchController.clear();
              });
            }
          },
          builder: (context, state) {
            if (state is FinishedProductLoading) {
              return const Loader();
            }

            if (state is FinishedProductError) {
              return ErrorStateWidget(
                title: strings.finishedProductsLoadError,
                message: ErrorMessages.networkError,
              );
            }

            if (state is FinishedProductLoaded) {
              if (finishedProducts.isEmpty) {
                return EmptyStateWidget(
                  title: strings.noFinishedProductsFound,
                  message: strings.noFinishedProductsMessage,
                );
              }

              return Column(
                children: [
                  _buildSearchBar(strings),
                  Expanded(
                    child: filteredProducts.isEmpty
                        ? EmptyStateWidget(
                            title: strings.noFinishedProductsFound,
                            message: strings.noFinishedProductsMessage,
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              return FinishedProductCard(
                                finishedProduct: filteredProducts[index],
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

  Widget _buildSearchBar(AppLocalizations strings) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          _onSearch(value);
          setState(() {});
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
