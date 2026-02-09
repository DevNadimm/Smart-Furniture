import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/custom_text_field.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/employee_sales_details_model.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/sale_item_model.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/sales/create_sales_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/sales_details/employee_sales_details_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/product_selection_page.dart';

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
  final _discountController = TextEditingController(text: '0');
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
    final discountPercent = double.tryParse(_discountController.text) ?? 0;
    return _subTotal * (discountPercent / 100);
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
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items,
          title: 'Select Customer',
          subtitle: 'Please choose a customer from the list',
          searchHint: 'Search customer...',
          selectedItem: _customerController.text,
          onItemSelected: (String selectedName) {
            _customerController.text = selectedName;
          },
        );
      },
    );
  }

  void _selectPaymentTypePicker(List<String> items) {
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: items,
          title: 'Select Payment Type',
          subtitle: 'Please choose a payment type from the list',
          searchHint: 'Search payment type...',
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
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_customerNameToId[_customerController.text] == null) {
      AppNotifier.showToast('Please select a customer', type: MessageType.error);
      return;
    }

    if (_selectedItems.isEmpty) {
      AppNotifier.showToast('Please add at least one product', type: MessageType.error);
      return;
    }

    final saleData = {
      'sale_date': _saleDateController.text,
      'customer_id': _customerNameToId[_customerController.text] ?? '',
      'items': _selectedItems.map((item) => item.toJson()).toList(),
      'sub_total': _subTotal,
      'discount': double.tryParse(_discountController.text) ?? 0,
      'grand_total': _grandTotal,
      'paid_amount': double.tryParse(_paidAmountController.text) ?? 0,
      'due_amount': _dueAmount,
      'payment_type': _paymentTypeController.text,
      'payment_info': _paymentInfoController.text.isEmpty
          ? null
          : _paymentInfoController.text,
    };

    context.read<CreateSalesBloc>().add(CreateSalesSubmitEvent(saleData));
    print('Sale Data: $saleData');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateSalesBloc, CreateSalesState>(
      listener: (context, createSalesState) {
        if (createSalesState is CreateSalesError) {
          AppNotifier.showToast(createSalesState.message, type: MessageType.error);
        } else if (createSalesState is CreateSalesSuccess) {
          AppNotifier.showToast('Sale created successfully', type: MessageType.success);
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
                  c.customer ?? '': (c.id?.toString() ?? '')
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
                _content(),
                if (salesDetailsState is SalesDetailsLoading || createSalesState is CreateSalesLoading)
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

  Widget _content() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Sales'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Sale Date',
                hintText: 'Select sale date',
                controller: _saleDateController,
                validationLabel: 'sale date',
                isRequired: true,
                readOnly: true,
                onTap: _selectDate,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Customer',
                hintText: 'Select customer',
                controller: _customerController,
                validationLabel: 'customer',
                isRequired: true,
                readOnly: true,
                onTap: () => _selectCustomerPicker(_customers.map((e) => e.customer ?? '').toList()),
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Products',
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
                    label: const Text(
                      'Add Products',
                      style: TextStyle(letterSpacing: 0, fontSize: 12),
                    ),
                    style: OutlinedButton.styleFrom(foregroundColor: AppColors.primaryColor, side: const BorderSide(width: 1, color: AppColors.primaryColor)),
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
                      'No products added!\n\nTap on the "Add Products" button to select products.',
                      style: GoogleFonts.poppins(
                        color: AppColors.secondaryFontColor,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                ..._selectedItems.map(
                  (item) => Container(
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
                    _buildPriceRow('Sub Total', '৳${_subTotal.toStringAsFixed(2)}'),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Discount',
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        SizedBox(
                          width: 80,
                          child: TextFormField(
                            controller: _discountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              border: OutlineInputBorder(),
                              suffixText: '%',
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    _buildPriceRow('Discount Amount', '-৳${_discountAmount.toStringAsFixed(2)}'),
                    const Divider(height: 18, thickness: 1, color: AppColors.borderColor),
                    _buildPriceRow(
                      'Grand Total',
                      '৳${_grandTotal.toStringAsFixed(2)}',
                      isBold: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Payment Type',
                hintText: 'Select payment type',
                controller: _paymentTypeController,
                validationLabel: 'payment type',
                isRequired: true,
                readOnly: true,
                onTap: () => _selectPaymentTypePicker(_paymentTypes.map((p) => p).toList()),
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Paid Amount',
                controller: _paidAmountController,
                validationLabel: 'paid amount',
                isRequired: true,
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Paid amount is required';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null) {
                    return 'Enter a valid amount';
                  }
                  if (amount > _grandTotal) {
                    return 'Paid amount cannot exceed grand total';
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
                      'Due Amount',
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
                label: 'Payment Info',
                controller: _paymentInfoController,
                validationLabel: 'payment info',
                hintText: 'Transaction ID, Reference, etc. (Optional)',
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _createSale,
                  child: const Text(
                    'Create Sale'
                  ),
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
