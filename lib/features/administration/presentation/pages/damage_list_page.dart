import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/filter_bar.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/damage_list/damage_list_bloc.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:smart_furniture/features/administration/presentation/widgets/damage_card.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';

class DamageListPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const DamageListPage());

  const DamageListPage({super.key});

  @override
  State<DamageListPage> createState() => _DamageListPageState();
}

class _DamageListPageState extends State<DamageListPage> {
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productIdController = TextEditingController();

  /// Map to lookup productId by productName
  Map<String, String> _productNameToId = {};

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _productIdController.dispose();
    super.dispose();
  }

  void _fetchData() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<DamageListBloc>().add(LoadDamageListEvent(selectedShop.name, _productIdController.text));
    } else {
      AppNotifier.showToast(ErrorMessages.unknownError, type: MessageType.error);
    }
  }

  void _fetchProducts() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<ProductListBloc>().add(LoadProductListEvent(selectedShop.name, ''));
    } else {
      AppNotifier.showToast(ErrorMessages.unknownError, type: MessageType.error);
    }
  }

  void _resetDamageList() {
    context.read<DamageListBloc>().add(ResetDamageListEvent());
  }

  void _selectProductPicker(List<String> items) {
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items,
          title: 'Select Product',
          subtitle: 'Choose a product from the list',
          searchHint: 'Search Product',
          selectedItem: _productNameController.text,
          onItemSelected: (String selectedName) {
            _productNameController.text = selectedName;
            _productIdController.text = _productNameToId[selectedName] ?? '';
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.damageListTitle),
        leading: IconButton(
          onPressed: () {
            _resetDamageList();
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<ProductListBloc, ProductListState>(
            builder: (context, state) {
              if (state is ProductListLoaded) {
                _productNameToId = {
                  for (var p in state.productListModel.data!)
                    p.productName ?? '': p.id?.toString() ?? ''
                };
                return FilterBar(
                  onApplyFilter: _fetchData,
                  showFilterPicker: true,
                  filterPickerController: _productNameController,
                  onFilterPickerTap: () {
                    _selectProductPicker(state.productListModel.data!.map((e) => e.productName ?? '').toList());
                  },
                  filterPickerLabel: strings.selectProduct,
                );
              } else if (state is ProductListLoading) {
                return FilterBar(
                  onApplyFilter: () {},
                  showFilterPicker: true,
                  filterPickerLabel: strings.selectProduct,
                );
              } else if (state is ProductListError) {
                return FilterBar(
                  onApplyFilter: _fetchData,
                  showFilterPicker: true,
                  filterPickerLabel: strings.selectProduct,
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
                child: BlocConsumer<DamageListBloc, DamageListState>(
                  listener: (context, state) {
                    if (state is DamageListError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is DamageListLoading) {
                      return const Loader();
                    }
                    if (state is DamageListInitial) {
                      return const EmptyStateWidget(
                        icon: HugeIcons.strokeRoundedDeliveryBox01,
                        title: 'Select a Product',
                        message: 'Choose a product from the filter above to see its damage history.',
                      );
                    }
                    if (state is DamageListError) {
                      return const ErrorStateWidget(
                        title: 'Failed to Load Damage List',
                        message: ErrorMessages.networkError,
                      );
                    }
                    if (state is DamageListLoaded) {
                      if (state.damageListModel.data?.isEmpty ?? false) {
                        return const EmptyStateWidget(
                          title: 'No Damage Records Found',
                          message: 'We couldn’t find any damage records for the selected filters. Try adjusting your filters or selecting a different time period.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.damageListModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final data = state.damageListModel.data?[index];
                            return DamageCard(damageData: data);
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
