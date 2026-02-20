import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/services/localization_service.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/custom_text_field.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/employee_sales_details_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/sale_item_model.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/employee_sales_details/employee_sales_details_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/sales/employee_sales_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/create_customer_page.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/product_selection_page.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class CreateSalesPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const CreateSalesPage());

  const CreateSalesPage({super.key});

  @override
  State<CreateSalesPage> createState() => _CreateSalesPageState();
}

class _CreateSalesPageState extends State<CreateSalesPage> {
  final _formKey = GlobalKey<FormState>();
  final _saleDateController = TextEditingController();
  final _customerController = TextEditingController();
  final _discountController = TextEditingController();
  final _paymentTypeController = TextEditingController();
  final _paidAmountController = TextEditingController();
  final _paymentInfoController = TextEditingController();

  List<SaleItem> _selectedItems = [];
  DateTime _selectedDate = DateTime.now();

  List<EmployeeProduct> _products = [];
  List<EmployeeCustomer> _customers = [];
  bool _isBranchUser = false;

  Map<String, String> _customerNameToId = {};
  final List<String> _paymentTypes = [
    'Cash',
    'QR Code',
    'Debit/Credit Cards',
    'Digital Wallet',
  ];

  @override
  void initState() {
    super.initState();
    _saleDateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
    _fetchDetails();
  }

  @override
  void dispose() {
    _saleDateController.dispose();
    _customerController.dispose();
    _discountController.dispose();
    _paidAmountController.dispose();
    _paymentInfoController.dispose();
    super.dispose();
  }

  _fetchDetails() => context.read<EmployeeSalesDetailsBloc>().add(LoadSalesDetailsEvent());

  double get _subTotal {
    return _selectedItems.fold(0.0, (sum, item) => sum + item.total);
  }

  double get _discountAmount {
    return double.tryParse(_discountController.text) ?? 0;
  }

  double get _grandTotal {
    return _subTotal - _discountAmount;
  }

  double get _dueAmount {
    final paidAmount = double.tryParse(_paidAmountController.text) ?? 0;
    return _grandTotal - paidAmount;
  }

  Future<void> _selectDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _saleDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _selectCustomerPicker(List<String> items) {
    final strings = AppLocalizations.of(context)!;
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items,
          title: strings.selectCustomerTitle,
          subtitle: strings.selectCustomerSubtitle,
          searchHint: strings.searchCustomer,
          selectedItem: _customerController.text,
          onItemSelected: (String selectedName) {
            _customerController.text = selectedName;
          },
        );
      },
    );
  }

  void _selectPaymentTypePicker(List<String> items) {
    final strings = AppLocalizations.of(context)!;
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items,
          title: strings.selectPaymentTypeTitle,
          subtitle: strings.selectPaymentTypeSubtitle,
          searchHint: strings.searchPaymentType,
          selectedItem: _paymentTypeController.text,
          onItemSelected: (String selectedName) {
            _paymentTypeController.text = selectedName;
          },
        );
      },
    );
  }

  Future<void> _selectProducts() async {
    if (_products.isEmpty) return;

    final result = await Navigator.push<List<SaleItem>>(
      context,
      ProductSelectionPage.route(
        products: _products,
        selectedItems: _selectedItems,
        isBranchUser: _isBranchUser,
      ),
    );

    if (result != null) {
      setState(() {
        _selectedItems = result;
      });
    }
  }

  void _removeItem(int productId) {
    setState(() {
      _selectedItems.removeWhere((item) => item.productId == productId);
    });
  }

  void _createSale() {
    final strings = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_customerNameToId[_customerController.text] == null) {
      AppNotifier.showToast(strings.pleaseSelectCustomer, type: MessageType.error);
      return;
    }

    if (_selectedItems.isEmpty) {
      AppNotifier.showToast(strings.pleaseAddProduct, type: MessageType.error);
      return;
    }

    final saleData = {
      'sale_date': _saleDateController.text,
      'customer_id': _customerNameToId[_customerController.text] ?? '',
      'items': _selectedItems.map((item) => item.toJson()).toList(),
      'sub_total': _subTotal,
      'discount': _discountAmount,
      'grand_total': _grandTotal,
      'paid_amount': double.tryParse(_paidAmountController.text) ?? 0,
      'due_amount': _dueAmount,
      'payment_type': _paymentTypeController.text,
      'payment_info': _paymentInfoController.text.isEmpty
          ? null
          : _paymentInfoController.text,
    };

    context.read<EmployeeSalesBloc>().add(CreateEmployeeSaleEvent(saleData));
    print('Sale Data: $saleData');
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    return BlocConsumer<EmployeeSalesBloc, EmployeeSalesState>(
      listener: (context, createSalesState) {
        if (createSalesState is EmployeeSalesError) {
          AppNotifier.showToast(createSalesState.message, type: MessageType.error);
        } else if (createSalesState is EmployeeSalesOperationSuccess) {
          AppNotifier.showToast(strings.saleCreatedSuccess, type: MessageType.success);
          Navigator.pop(context);
        }
      },
      builder: (context, createSalesState) {
        return BlocConsumer<EmployeeSalesDetailsBloc, EmployeeSalesDetailsState>(
          listener: (context, salesDetailsState) {
            if (salesDetailsState is SalesDetailsError) {
              AppNotifier.showToast(salesDetailsState.message, type: MessageType.error);
            } else if (salesDetailsState is SalesDetailsLoaded) {
              _customerNameToId = {
                for (var c in salesDetailsState.salesDetailsModel.data!.customers!)
                  LocalizationService.getText(context, en: c.customer ?? strings.notAvailable, bn: c.nameBn): (c.id?.toString() ?? '')
              };
              final data = salesDetailsState.salesDetailsModel.data;
              if (data != null) {
                setState(() {
                  _products = data.products ?? [];
                  _customers = data.customers ?? [];
                  _isBranchUser = data.isBranchUser ?? false;
                });
              }
            }
          },
          builder: (context, salesDetailsState) {
            return Stack(
              children: [
                _content(strings),
                if (salesDetailsState is SalesDetailsLoading || createSalesState is EmployeeSalesOperationLoading)
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: AppColors.black.withValues(alpha: 0.6),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.white,
                      ),
                    ),
                  )
              ],
            );
          },
        );
      },
    );
  }

  Widget _content(AppLocalizations strings) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.createSales),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: strings.saleDate,
                hintText: strings.selectSaleDate,
                controller: _saleDateController,
                validationLabel: 'sale date',
                isRequired: true,
                readOnly: true,
                onTap: _selectDate,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: strings.customer,
                addCustomer:  OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(context, CreateCustomerPage.route());
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: Text(
                    strings.addCustomer,
                    style: const TextStyle(letterSpacing: 0, fontSize: 12),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    side: const BorderSide(width: 1, color: AppColors.primaryColor),
                  ),
                ),
                hintText: strings.selectCustomer,
                controller: _customerController,
                validationLabel: 'customer',
                isRequired: true,
                readOnly: true,
                onTap: () => _selectCustomerPicker(_customerNameToId.keys.toList()),
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    strings.products,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: _selectProducts,
                    icon: const Icon(Icons.add, size: 18),
                    label: Text(
                      strings.addProducts,
                      style: const TextStyle(letterSpacing: 0, fontSize: 12),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      side: const BorderSide(
                        width: 1,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (_selectedItems.isEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor, width: 1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Center(
                    child: Text(
                      strings.noProductsAdded,
                      style: GoogleFonts.poppins(
                        color: AppColors.secondaryFontColor,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                ..._selectedItems.map((item) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const HugeIcon(
                              icon: HugeIcons.strokeRoundedDeliveryBox01,
                              size: 24,
                              color: AppColors.primaryFontColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.productName,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${item.quantity} × ৳${item.unitPrice.toStringAsFixed(2)} = ৳${item.total.toStringAsFixed(2)}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const HugeIcon(
                              icon: HugeIcons.strokeRoundedDelete03,
                              color: Colors.red,
                            ),
                            onPressed: () => _removeItem(item.productId),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor, width: 1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _buildPriceRow(strings.subTotal, '৳${_subTotal.toStringAsFixed(2)}'),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          strings.discount,
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        SizedBox(
                          width: 120,
                          child: TextFormField(
                            controller: _discountController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                            ],
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              border: OutlineInputBorder(),
                              prefixText: '৳',
                              hintText: '0.00',
                            ),
                            onChanged: (_) => setState(() {}),
                            validator: (value) {
                              if (value != null && value.isNotEmpty) {
                                final discount = double.tryParse(value);
                                if (discount == null) {
                                  return strings.invalidAmount;
                                }
                                if (discount > _subTotal) {
                                  return strings.cannotExceedSubtotal;
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _buildPriceRow(strings.discountAmount, '-৳${_discountAmount.toStringAsFixed(2)}'),
                    const Divider(height: 18, thickness: 1, color: AppColors.borderColor),
                    _buildPriceRow(
                      strings.grandTotal,
                      '৳${_grandTotal.toStringAsFixed(2)}',
                      isBold: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: strings.paymentType,
                hintText: strings.selectPaymentType,
                controller: _paymentTypeController,
                validationLabel: 'payment type',
                isRequired: true,
                readOnly: true,
                onTap: () => _selectPaymentTypePicker(_paymentTypes.map((p) => p).toList()),
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: strings.paidAmount,
                controller: _paidAmountController,
                validationLabel: 'paid amount',
                isRequired: true,
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return strings.paidAmountRequired;
                  }
                  final amount = double.tryParse(value);
                  if (amount == null) {
                    return strings.enterValidAmount;
                  }
                  if (amount > _grandTotal) {
                    return strings.paidAmountExceedsTotal;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _dueAmount > 0 ? Colors.red[50] : Colors.green[50],
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: _dueAmount > 0 ? Colors.red[200]! : Colors.green[200]!,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      strings.dueAmount,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                    Text(
                      '৳${_dueAmount.toStringAsFixed(2)}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: _dueAmount > 0 ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: strings.paymentInfo,
                controller: _paymentInfoController,
                validationLabel: 'payment info',
                hintText: strings.paymentInfoHint,
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _createSale,
                  child: Text(strings.createSale),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}