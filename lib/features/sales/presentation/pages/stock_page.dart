import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:smart_furniture/core/utils/widgets/app_bar_search_field.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/sales/presentation/blocs/stock/stock_bloc.dart';
import 'package:smart_furniture/features/sales/presentation/widgets/stock_card.dart';

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

  bool _isSearching = false;

  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _fetchData() {
    context.read<StockBloc>().add(
      LoadStockEvent(
        fromDate: _fromDateController.text,
        toDate: _toDateController.text,
        search: _searchController.text,
      ),
    );
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

    return Scaffold(
      appBar: AppBar(
        title: _isSearching
            ? AppBarSearchField(
                controller: _searchController,
                onSubmitted: _onSearchSubmitted,
                hintText: 'Search Stocks...',
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
          FilterBar(
            fromDateController: _fromDateController,
            toDateController: _toDateController,
            onFilterPressed: _fetchData,
            onSelectDate: _selectDate,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<StockBloc, StockState>(
                  listener: (context, state) {
                    if (state is StockError) {
                      AppNotifier.showToast(state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is StockLoading) {
                      return const Loader();
                    }
                    if (state is StockLoaded) {
                      if (state.stock.data?.isEmpty ?? false) {
                        return const EmptyStateWidget(
                          title: 'No Stock Records Found',
                          message: 'We couldn’t find any stock records for the selected criteria. Try adjusting your filters or checking a different category or date range.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.stock.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final stock = state.stock.data?[index];
                            return StockCard(stockData: stock);
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
