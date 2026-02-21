import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
import 'package:smart_furniture/features/admin/presentation/blocs/purchase/purchase_bloc.dart';
import 'package:smart_furniture/features/admin/presentation/pages/purchase_details_page.dart';
import 'package:smart_furniture/features/admin/presentation/widgets/purchase_card.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/finished_product_category/finished_product_category_bloc.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class PurchasePage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const PurchasePage());

  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {

  /// FILTER CONTROLLERS
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();

  Map<String, String> _categoryIdToName = {};

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchPurchases();
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    _categoryNameController.dispose();
    _categoryIdController.dispose();
    super.dispose();
  }

  /// ================= FETCH =================

  void _fetchPurchases() {
    context.read<PurchaseBloc>().add(
      LoadPurchasesEvent(
        fromDate: _fromDateController.text.isNotEmpty ? _fromDateController.text : null,
        toDate: _toDateController.text.isNotEmpty ? _toDateController.text : null,
        categoryId: _categoryIdController.text.isNotEmpty ? _categoryIdController.text : null,
      ),
    );
  }

  void _clearFilters() {
    setState(() {
      _fromDateController.clear();
      _toDateController.clear();
      _categoryNameController.clear();
      _categoryIdController.clear();
    });
    _fetchPurchases();
  }

  void _fetchCategories() {
    context.read<FinishedProductCategoryBloc>().add(LoadFinishedProductCategoriesEvent());
  }

  /// ================= DATE PICKER =================

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  /// ================= CATEGORY PICKER =================

  void _selectCategoryPicker(List<Map<String, String>> items) {
    final strings = AppLocalizations.of(context)!;

    showBarModalBottomSheet(
      context: context,
      builder: (_) {
        return SearchableBottomSheet(
          items: items.map((e) => e['name']!).toList(),
          title: strings.selectCategory,
          subtitle: strings.selectCategorySubtitle,
          searchHint: strings.searchCategory,
          selectedItem: _categoryNameController.text,
          onItemSelected: (selectedName) {
            // Find the original ID using the displayed name
            final selectedItem = items.firstWhere(
                  (item) => item['name'] == selectedName,
              orElse: () => {'id': '', 'name': ''},
            );

            setState(() {
              _categoryNameController.text = selectedName;
              _categoryIdController.text = selectedItem['id']!;
            });
          },
        );
      },
    );
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.purchases),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchPurchases,
          ),
        ],
      ),

      body: Column(
        children: [

          /// ===== FILTER BAR =====
          BlocBuilder<FinishedProductCategoryBloc,
              FinishedProductCategoryState>(
            builder: (context, state) {

              if (state is FinishedProductCategoryLoaded) {

                // Store ID to Name mapping
                _categoryIdToName = {
                  for (var c in state.categories)
                    (c.id?.toString() ?? ''): (c.categoryName ?? '')
                };

                // Build items list with localized names
                final items = state.categories.map((e) {
                  final localizedName = LocalizationService.getText(
                    context,
                    en: e.categoryName ?? '',
                    bn: e.nameBn ?? '',
                  );
                  return {
                    'id': e.id?.toString() ?? '',
                    'name': localizedName,
                  };
                }).toList();

                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchPurchases,
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerController: _categoryNameController,
                  filterPickerLabel: strings.category,
                  onFilterPickerTap: () => _selectCategoryPicker(items),
                );
              }

              return FilterBar(
                startDateController: _fromDateController,
                endDateController: _toDateController,
                onApplyFilter: _fetchPurchases,
                onSelectDate: _selectDate,
                showFilterPicker: true,
                filterPickerLabel: strings.category,
              );
            },
          ),

          /// ===== PURCHASE LIST =====
          Expanded(
            child: BlocConsumer<PurchaseBloc, PurchaseState>(
              listener: (context, state) {
                if (state is PurchaseError) {
                  AppNotifier.showToast(
                      state.message,
                      type: MessageType.error);
                }
              },
              builder: (context, state) {

                if (state is PurchaseLoading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Loader(),
                  );
                }

                if (state is PurchaseError) {
                  return ErrorStateWidget(
                    title: strings.purchaseLoadError,
                    message: ErrorMessages.networkError,
                  );
                }

                if (state is PurchaseLoaded) {

                  if (state.purchases.purchases?.isEmpty ?? true) {
                    return EmptyStateWidget(
                      title: strings.noPurchasesFound,
                      message: strings.noPurchasesMessage,
                    );
                  }

                  return SingleChildScrollView(
                    child: Column(
                      children: [

                        /// SUMMARY
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: SummaryCard(
                            amount: state.purchases.summary?.totalAmount?.toDouble() ?? 0,
                            amountLabel: strings.totalAmount,
                            quantity: state.purchases.summary?.totalPurchases ?? 0,
                            quantityLabel: strings.totalPurchases,
                          ),
                        ),

                        /// LIST
                        ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.purchases.purchases?.length ?? 0,
                          itemBuilder: (context, index) {
                            return PurchaseCard(
                              purchase: state.purchases.purchases![index],
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PurchaseDetailsPage.route(
                                    purchaseId: state.purchases.purchases?[index].id ?? 0,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}