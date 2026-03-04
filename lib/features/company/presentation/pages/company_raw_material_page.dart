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
import 'package:smart_furniture/features/company/presentation/blocs/company_raw_material/company_raw_material_bloc.dart';
import 'package:smart_furniture/features/company/presentation/widgets/company_raw_material_card.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/raw_material_category/raw_material_category_bloc.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class CompanyRawMaterialPage extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const CompanyRawMaterialPage());

  const CompanyRawMaterialPage({super.key});

  @override
  State<CompanyRawMaterialPage> createState() => _CompanyRawMaterialPageState();
}

class _CompanyRawMaterialPageState extends State<CompanyRawMaterialPage> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();

  bool _isSearching = false;

  Map<String, String> _categoryNameToId = {};

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchRawMaterials();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _categoryNameController.dispose();
    _categoryIdController.dispose();
    super.dispose();
  }

  void _fetchRawMaterials() {
    context.read<CompanyRawMaterialBloc>().add(
      LoadCompanyRawMaterialsEvent(
        categoryId: _categoryIdController.text.isEmpty
            ? null
            : _categoryIdController.text,
        search: _searchController.text.trim().isEmpty
            ? null
            : _searchController.text.trim(),
      ),
    );
  }

  void _fetchCategories() {
    context
        .read<RawMaterialCategoryBloc>()
        .add(LoadRawMaterialCategoriesEvent());
  }

  // ── Search ───────────────────────────────────────────────

  void _startSearch() => setState(() => _isSearching = true);

  void _stopSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
    _fetchRawMaterials();
  }

  void _onSearchSubmitted(String _) => _fetchRawMaterials();

  // ── Category Picker ──────────────────────────────────────

  void _showCategoryPicker(AppLocalizations strings) {
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) => SearchableBottomSheet(
        items: _categoryNameToId.keys.toList(),
        title: strings.selectCategoryTitle,
        subtitle: strings.selectCategorySubtitle,
        searchHint: strings.searchCategory,
        selectedItem: _categoryNameController.text,
        onItemSelected: (selectedName) {
          _categoryNameController.text = selectedName;
          _categoryIdController.text = _categoryNameToId[selectedName] ?? '';
          _fetchRawMaterials();
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
            hintText: strings.searchRawMaterials,
            border: InputBorder.none,
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
        )
            : Text(strings.rawMaterials),
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
          BlocBuilder<RawMaterialCategoryBloc, RawMaterialCategoryState>(
            builder: (context, state) {
              if (state is RawMaterialCategoryLoaded) {
                _categoryNameToId = {
                  for (final c in state.categories)
                    LocalizationService.getText(
                      context,
                      en: c.categoryName ?? strings.notAvailable,
                      bn: c.nameBn ?? '',
                    ): (c.id?.toString() ?? ''),
                };
              }

              return FilterBar(
                showFilterPicker: true,
                filterPickerController: _categoryNameController,
                filterPickerLabel: strings.category,
                onFilterPickerTap: state is RawMaterialCategoryLoaded
                    ? () => _showCategoryPicker(strings)
                    : null,
                onApplyFilter: _fetchRawMaterials,
              );
            },
          ),

          // ── Raw Material List ────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child:
              BlocConsumer<CompanyRawMaterialBloc, CompanyRawMaterialState>(
                listener: (context, state) {
                  if (state is CompanyRawMaterialError) {
                    AppNotifier.showToast(state.message,
                        type: MessageType.error);
                  }
                },
                builder: (context, state) {
                  if (state is CompanyRawMaterialLoading) {
                    return const Loader();
                  }

                  if (state is CompanyRawMaterialError) {
                    return ErrorStateWidget(
                      title: strings.rawMaterialsLoadError,
                      message: ErrorMessages.networkError,
                    );
                  }

                  if (state is CompanyRawMaterialLoaded) {
                    final products = state.rawMaterials.data ?? [];
                    final summary = state.rawMaterials.summary;

                    if (products.isEmpty) {
                      return EmptyStateWidget(
                        title: strings.noRawMaterialsFound,
                        message: strings.noRawMaterialsMessage,
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
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return CompanyRawMaterialCard(
                                rawMaterial: products[index],
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
          ),
        ],
      ),
    );
  }
}