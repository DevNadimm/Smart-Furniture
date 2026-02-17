import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/colors.dart';
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
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/finished_product_category/finished_product_category_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/sales/employee_sales_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/create_sales_page.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/widgets/employee_sales_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class EmployeeSalesPage extends StatefulWidget {
  static Route route({bool? isAdmin, int? branchId}) => MaterialPageRoute(builder: (_) => EmployeeSalesPage(isAdmin: isAdmin ?? false, branchId: branchId));

  final bool isAdmin;
  final int? branchId;

  const EmployeeSalesPage({super.key, required this.isAdmin, this.branchId});

  @override
  State<EmployeeSalesPage> createState() => _EmployeeSalesPageState();
}

class _EmployeeSalesPageState extends State<EmployeeSalesPage> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();

  /// Map to lookup categoryId by categoryName
  Map<String, String> _categoryNameToId = {};

  @override
  void initState() {
    super.initState();
    _fetchCategories();
    _fetchSales();
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    _categoryNameController.dispose();
    _categoryIdController.dispose();
    super.dispose();
  }

  void _fetchSales() {
    context.read<EmployeeSalesBloc>().add(
      LoadEmployeeSalesEvent(
        branchId: widget.branchId,
        fromDate: _fromDateController.text,
        toDate: _toDateController.text,
        categoryId: _categoryIdController.text,
      ),
    );
  }

  void _fetchCategories() {
    // Fetch categories for the filter
    // You may need to adjust this based on how categories are fetched for employee dashboard
    // For now, assuming a similar approach to sales record page
    context.read<FinishedProductCategoryBloc>().add(LoadFinishedProductCategoriesEvent());
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  void _selectCategoryPicker(List<String> items, BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items,
          title: strings.selectCategoryTitle,
          subtitle: strings.selectCategorySubtitle,
          searchHint: strings.searchCategory,
          selectedItem: _categoryNameController.text,
          onItemSelected: (String selectedName) {
            _categoryNameController.text = selectedName;
            _categoryIdController.text = _categoryNameToId[selectedName] ?? '';
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.sales),
      ),
      floatingActionButton: !widget.isAdmin
          ? FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            CreateSalesPage.route(),
          );
          _fetchSales();
        },
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.white,
        elevation: 2,
        child: const Icon(Icons.add),
      )
          : null,
      body: Column(
        children: [
          BlocBuilder<FinishedProductCategoryBloc, FinishedProductCategoryState>(
            builder: (context, state) {
              if (state is FinishedProductCategoryLoaded) {
                _categoryNameToId = {
                  for (var c in state.categories)
                    (locale == 'bn' ? (c.nameBn ?? '') : (c.categoryName ?? '')):
                    (c.id?.toString() ?? '')
                };
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchSales,
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerController: _categoryNameController,
                  onFilterPickerTap: () {
                    _selectCategoryPicker(
                      state.categories.map((e) => LocalizationService.getText(
                        context,
                        en: e.categoryName ?? '',
                        bn: e.nameBn ?? '',
                      )).toList(),
                      context,
                    );
                  },
                  filterPickerLabel: strings.category,
                );
              } else if (state is FinishedProductCategoryLoading) {
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: () {},
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerLabel: strings.category,
                );
              } else if (state is FinishedProductCategoryError) {
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchSales,
                  onSelectDate: _selectDate,
                  showFilterPicker: true,
                  filterPickerLabel: strings.category,
                );
              } else {
                return FilterBar(
                  startDateController: _fromDateController,
                  endDateController: _toDateController,
                  onApplyFilter: _fetchSales,
                  onSelectDate: _selectDate,
                );
              }
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<EmployeeSalesBloc, EmployeeSalesState>(
                  listener: (context, state) {
                    if (state is EmployeeSalesError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                    if (state is EmployeeSalesOperationSuccess) {
                      AppNotifier.showToast(state.message, type: MessageType.success);
                    }
                  },
                  builder: (context, state) {
                    if (state is EmployeeSalesLoading) {
                      return const Loader();
                    }

                    if (state is EmployeeSalesError) {
                      return const ErrorStateWidget(
                        title: 'Failed to Load Sales',
                        message: ErrorMessages.networkError,
                      );
                    }

                    if (state is EmployeeSalesLoaded) {
                      if (state.salesModel.data?.isEmpty ?? true) {
                        return const EmptyStateWidget(
                          title: 'No Sales Found',
                          message: "We couldn't find any sales records for the selected date range. Try adjusting your filters or selecting a different time period.",
                        );
                      }

                      return Column(
                        children: [
                          SummaryCard(
                            amount: state.salesModel.summary?.totalAmount?.toDouble() ?? 0.0,
                            amountLabel: strings.totalSalesAmount,
                            quantity: state.salesModel.summary?.totalQuantity ?? 0,
                            quantityLabel: strings.totalSalesQuantity,
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state.salesModel.data!.length,
                            itemBuilder: (context, index) {
                              return EmployeeSalesCard(
                                sale: state.salesModel.data![index],
                              );
                            },
                          ),
                        ],
                      );
                    }

                    // Show loader when operation is in progress
                    if (state is EmployeeSalesOperationLoading) {
                      return const Loader();
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