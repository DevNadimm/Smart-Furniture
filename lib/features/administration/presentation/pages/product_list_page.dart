import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/utils/widgets/app_bar_search_field.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:smart_furniture/features/administration/presentation/widgets/product_card.dart';

class ProductListPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const ProductListPage());

  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final TextEditingController _searchController = TextEditingController();

  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchData() {
    context.read<ProductListBloc>().add(
      LoadProductListEvent(_searchController.text),
    );
  }

  void _startSearch() => setState(() => _isSearching = true);

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

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? AppBarSearchField(
                controller: _searchController,
                onSubmitted: _onSearchSubmitted,
                hintText: 'Search Product...',
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<ProductListBloc, ProductListState>(
                  listener: (context, state) {
                    if (state is ProductListError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is ProductListLoading) {
                      return const Loader();
                    }
                    if (state is ProductListLoaded) {
                      if (state.productListModel.data!.isEmpty) {
                        return const EmptyStateWidget(
                          title: 'No Products Found',
                          message: 'We couldn’t find any product records. Try adjusting your search filters or adding new products to see them here.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.productListModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final product = state.productListModel.data![index];
                            return ProductCard(product: product);
                          },
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
