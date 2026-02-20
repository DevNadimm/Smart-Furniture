import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/custom_text_field.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/custom_order/data/repositories/custom_order_repository.dart';
import 'package:smart_furniture/features/custom_order/presentation/blocs/store_custom_order/store_custom_order_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/customer/customer_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/create_customer_page.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class _CustomOrderItem {
  final String productName;
  final String unit;
  final int orderedQuantity;
  final double unitPrice;
  final File? imageFile;

  _CustomOrderItem({
    required this.productName,
    required this.unit,
    required this.orderedQuantity,
    required this.unitPrice,
    this.imageFile,
  });

  double get totalPrice => orderedQuantity * unitPrice;

  _CustomOrderItem copyWith({
    String? productName,
    String? unit,
    int? orderedQuantity,
    double? unitPrice,
    File? imageFile,
  }) {
    return _CustomOrderItem(
      productName: productName ?? this.productName,
      unit: unit ?? this.unit,
      orderedQuantity: orderedQuantity ?? this.orderedQuantity,
      unitPrice: unitPrice ?? this.unitPrice,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}

class CreateCustomOrderPage extends StatefulWidget {
  static Route route({int? branchId}) => MaterialPageRoute(builder: (_) => CreateCustomOrderPage(branchId: branchId));

  final int? branchId;

  const CreateCustomOrderPage({super.key, this.branchId});

  @override
  State<CreateCustomOrderPage> createState() => _CreateCustomOrderPageState();
}

class _CreateCustomOrderPageState extends State<CreateCustomOrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _orderDateController = TextEditingController();
  final _expectedDeliveryController = TextEditingController();
  final _customerController = TextEditingController();
  final _deliveryAddressController = TextEditingController();
  final _notesController = TextEditingController();
  final _discountController = TextEditingController();
  final _paidAmountController = TextEditingController();

  DateTime _selectedOrderDate = DateTime.now();
  String? _selectedCustomerId;
  Map<String, String> _customerNameToId = {};
  final List<_CustomOrderItem> _items = [];

  @override
  void initState() {
    super.initState();
    _orderDateController.text =
        DateFormat('yyyy-MM-dd').format(_selectedOrderDate);
    _fetchCustomers();
  }

  @override
  void dispose() {
    _orderDateController.dispose();
    _expectedDeliveryController.dispose();
    _customerController.dispose();
    _deliveryAddressController.dispose();
    _notesController.dispose();
    _discountController.dispose();
    _paidAmountController.dispose();
    super.dispose();
  }

  void _fetchCustomers() {
    context.read<CustomerBloc>().add(LoadCustomersEvent());
  }

  // ── Computeds ────────────────────────────────────────────────────────────────
  double get _subTotal =>
      _items.fold(0.0, (sum, item) => sum + item.totalPrice);

  double get _discountAmount =>
      double.tryParse(_discountController.text) ?? 0.0;

  double get _totalAmount => _subTotal - _discountAmount;

  double get _paidAmount =>
      double.tryParse(_paidAmountController.text) ?? 0.0;

  double get _dueAmount => (_totalAmount - _paidAmount).clamp(0, double.infinity);

  // ── Date pickers ─────────────────────────────────────────────────────────────
  Future<void> _selectOrderDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedOrderDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedOrderDate = picked;
        _orderDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectExpectedDelivery() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) {
      setState(() {
        _expectedDeliveryController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  // ── Customer picker ───────────────────────────────────────────────────────────
  void _selectCustomerPicker() {
    final strings = AppLocalizations.of(context)!;
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) => SearchableBottomSheet(
        items: _customerNameToId.keys.toList(),
        title: strings.selectCustomerTitle,
        subtitle: strings.selectCustomerSubtitle,
        searchHint: strings.searchCustomer,
        selectedItem: _customerController.text,
        onItemSelected: (name) {
          setState(() {
            _customerController.text = name;
            _selectedCustomerId = _customerNameToId[name];
          });
        },
      ),
    );
  }

  void _showAddItemSheet({int? editIndex}) {
    final strings = AppLocalizations.of(context)!;
    final isEdit = editIndex != null;
    final existing = isEdit ? _items[editIndex] : null;

    final nameCtrl = TextEditingController(text: existing?.productName ?? '');
    final unitCtrl = TextEditingController(text: existing?.unit ?? '');
    final qtyCtrl = TextEditingController(text: existing != null ? existing.orderedQuantity.toString() : '1');
    final priceCtrl = TextEditingController(text: existing != null ? existing.unitPrice.toStringAsFixed(2) : '');
    File? pickedImage = existing?.imageFile;
    final sheetFormKey = GlobalKey<FormState>();

    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) {
            Future<void> pickImage() async {
              final picker = ImagePicker();

              final source = await showModalBottomSheet<ImageSource>(
                context: ctx,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) => SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: AppColors.borderColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          strings.selectImageSource, // Add this string to your localizations
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryFontColor,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const HugeIcon(
                              icon: HugeIcons.strokeRoundedImage01,
                              color: AppColors.primaryColor,
                              size: 22,
                            ),
                          ),
                          title: Text(
                            strings.gallery, // Add this string
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () => Navigator.pop(context, ImageSource.gallery),
                        ),
                        ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const HugeIcon(
                              icon: HugeIcons.strokeRoundedCamera01,
                              color: AppColors.primaryColor,
                              size: 22,
                            ),
                          ),
                          title: Text(
                            strings.camera, // Add this string
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () => Navigator.pop(context, ImageSource.camera),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              );

              if (source == null) return;

              final picked = await picker.pickImage(source: source);
              if (picked != null) {
                setSheetState(() => pickedImage = File(picked.path));
              }
            }

            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 24,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              ),
              child: Form(
                key: sheetFormKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: HugeIcon(
                              icon: isEdit
                                  ? HugeIcons.strokeRoundedEdit01
                                  : HugeIcons.strokeRoundedAdd01,
                              color: AppColors.primaryColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            isEdit
                                ? strings.editItem
                                : strings.addItem,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryFontColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      /// Product name
                      CustomTextField(
                        label: strings.productName,
                        controller: nameCtrl,
                        validationLabel: 'product name',
                        isRequired: true,
                        hintText: strings.enterProductName,
                      ),
                      const SizedBox(height: 14),

                      /// Unit + Qty row
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextField(
                              label: strings.unit,
                              controller: unitCtrl,
                              validationLabel: 'unit',
                              isRequired: true,
                              hintText: 'PCS',
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CustomTextField(
                              label: strings.quantity,
                              controller: qtyCtrl,
                              validationLabel: 'quantity',
                              isRequired: true,
                              keyboardType: TextInputType.number,
                              validator: (v) {
                                if (v == null || v.isEmpty) return strings.required;
                                if ((int.tryParse(v) ?? 0) <= 0) {
                                  return strings.invalidAmount;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      /// Unit price
                      CustomTextField(
                        label: strings.unitPrice,
                        controller: priceCtrl,
                        validationLabel: 'unit price',
                        isRequired: true,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        validator: (v) {
                          if (v == null || v.isEmpty) return strings.required;
                          if ((double.tryParse(v) ?? 0) <= 0) {
                            return strings.invalidAmount;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      Text(
                        strings.itemImage,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryFontColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: pickImage,
                        child: Container(
                          height: 110,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor.withValues(alpha: 0.04),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: pickedImage != null
                                  ? AppColors.primaryColor
                                  : AppColors.borderColor,
                              width: pickedImage != null ? 2 : 1,
                            ),
                          ),
                          child: pickedImage != null
                              ? Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(11),
                                child: Image.file(
                                  pickedImage!,
                                  width: double.infinity,
                                  height: 110,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 6,
                                right: 6,
                                child: GestureDetector(
                                  onTap: () => setSheetState(() => pickedImage = null),
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(Icons.close,
                                        color: Colors.white, size: 14),
                                  ),
                                ),
                              ),
                            ],
                          )
                              : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HugeIcon(
                                icon: HugeIcons.strokeRoundedImageUpload,
                                color: AppColors.primaryColor.withValues(alpha: 0.5),
                                size: 32,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                strings.tapToUploadImage,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      /// Save button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (!sheetFormKey.currentState!.validate()) return;
                            final newItem = _CustomOrderItem(
                              productName: nameCtrl.text.trim(),
                              unit: unitCtrl.text.trim(),
                              orderedQuantity: int.parse(qtyCtrl.text),
                              unitPrice: double.parse(priceCtrl.text),
                              imageFile: pickedImage,
                            );
                            setState(() {
                              if (isEdit) {
                                _items[editIndex] = newItem;
                              } else {
                                _items.add(newItem);
                              }
                            });
                            Navigator.pop(ctx);
                          },
                          icon: HugeIcon(
                            icon: isEdit
                                ? HugeIcons.strokeRoundedEdit01
                                : HugeIcons.strokeRoundedAdd01,
                            color: AppColors.white,
                            size: 20,
                          ),
                          label: Text(
                            isEdit ? strings.updateItem : strings.addItem,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _removeItem(int index) {
    setState(() => _items.removeAt(index));
  }

  // ── Submit ────────────────────────────────────────────────────────────────────
  void _submit() {
    final strings = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) return;

    if (_selectedCustomerId == null) {
      AppNotifier.showToast(strings.pleaseSelectCustomer, type: MessageType.error);
      return;
    }

    if (_items.isEmpty) {
      AppNotifier.showToast(strings.pleaseAddProduct, type: MessageType.error);
      return;
    }

    final fields = {
      'order_date': _orderDateController.text,
      'customer_id': _selectedCustomerId!,
      'expected_delivery_date': _expectedDeliveryController.text,
      'sub_total': _subTotal.toStringAsFixed(2),
      'discount': _discountAmount.toStringAsFixed(2),
      'total_amount': _totalAmount.toStringAsFixed(2),
      'paid_amount': _paidAmount.toStringAsFixed(2),
      'due_amount': _dueAmount.toStringAsFixed(2),
      'delivery_address': _deliveryAddressController.text.trim(),
      'notes': _notesController.text.trim(),
    };

    final items = _items.map((e) => CustomOrderItemPayload(
      productName: e.productName,
      unit: e.unit,
      orderedQuantity: e.orderedQuantity,
      unitPrice: e.unitPrice,
      imageFile: e.imageFile,
    )).toList();

    context.read<StoreCustomOrderBloc>().add(
      StoreCustomOrderSubmitEvent(fields: fields, items: items),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;

    return BlocConsumer<StoreCustomOrderBloc, StoreCustomOrderState>(
      listener: (context, state) {
        if (state is StoreCustomOrderError) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        } else if (state is StoreCustomOrderSuccess) {
          AppNotifier.showToast(state.message, type: MessageType.success);
          context.read<StoreCustomOrderBloc>().add(ResetStoreCustomOrderEvent());
          Navigator.pop(context, true);
        }
      },
      builder: (context, storeState) {
        return BlocConsumer<CustomerBloc, CustomerState>(
          listener: (context, customerState) {
            if (customerState is CustomerLoaded) {
              setState(() {
                _customerNameToId = {
                  for (var c in customerState.customerModel.data!)
                    (locale == 'bn'
                        ? (c.nameBn ?? c.name ?? '')
                        : (c.name ?? '')): (c.id?.toString() ?? '')
                };
              });
            }
          },
          builder: (context, customerState) {
            return Stack(
              children: [
                _buildContent(strings),
                if (storeState is StoreCustomOrderLoading || customerState is CustomerLoading)
                  Container(
                    color: AppColors.black.withValues(alpha: 0.6),
                    child: const Center(
                      child: CircularProgressIndicator(color: AppColors.white),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildContent(AppLocalizations strings) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.createCustomOrder),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: strings.orderDate,
                hintText: strings.selectOrderDate,
                controller: _orderDateController,
                validationLabel: 'order date',
                isRequired: true,
                readOnly: true,
                onTap: _selectOrderDate,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: strings.expectedDelivery,
                hintText: strings.selectExpectedDelivery,
                controller: _expectedDeliveryController,
                validationLabel: 'expected delivery date',
                isRequired: true,
                readOnly: true,
                onTap: _selectExpectedDelivery,
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
                      side: const BorderSide(width: 1, color: AppColors.primaryColor)
                  ),
                ),
                hintText: strings.selectCustomer,
                controller: _customerController,
                validationLabel: 'customer',
                isRequired: true,
                readOnly: true,
                onTap: _selectCustomerPicker,
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: strings.deliveryAddress,
                hintText: strings.enterDeliveryAddress,
                controller: _deliveryAddressController,
                validationLabel: 'delivery address',
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: strings.notes,
                hintText: strings.enterNotes,
                controller: _notesController,
                validationLabel: 'notes',
                maxLines: 3,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _sectionHeader(
                    icon: HugeIcons.strokeRoundedPackage,
                    title: strings.orderItems,
                    margin: EdgeInsets.zero,
                  ),
                  OutlinedButton.icon(
                    onPressed: () => _showAddItemSheet(),
                    icon: const Icon(Icons.add, size: 18),
                    label: Text(
                      strings.addItem,
                      style: const TextStyle(letterSpacing: 0, fontSize: 12),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.primaryColor,
                      side: const BorderSide(
                          width: 1, color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (_items.isEmpty)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 28),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.borderColor, width: 1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedPackage,
                        color: AppColors.grey.withValues(alpha: 0.4),
                        size: 40,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        strings.noItemsAdded,
                        style: GoogleFonts.poppins(
                          color: AppColors.secondaryFontColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _items.length,
                  itemBuilder: (_, index) =>
                      _buildItemCard(index),
                ),
              const SizedBox(height: 24),
              _sectionHeader(
                icon: HugeIcons.strokeRoundedWallet01,
                title: strings.pricingSummary,
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border:
                  Border.all(color: AppColors.borderColor, width: 1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    _buildPriceRow(strings.subTotal, '৳${_subTotal.toStringAsFixed(2)}'),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          strings.discount,
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                        SizedBox(
                          width: 130,
                          child: TextFormField(
                            controller: _discountController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                            ],
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              border: OutlineInputBorder(),
                              prefixText: '৳ ',
                              hintText: '0.00',
                            ),
                            onChanged: (_) => setState(() {}),
                            validator: (v) {
                              if (v != null && v.isNotEmpty) {
                                final d = double.tryParse(v);
                                if (d == null) return strings.invalidAmount;
                                if (d > _subTotal) {
                                  return strings.cannotExceedSubtotal;
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Divider(height: 16, thickness: 1, color: AppColors.borderColor),
                    _buildPriceRow(
                      strings.totalAmount,
                      '৳${_totalAmount.toStringAsFixed(2)}',
                      isBold: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: strings.paidAmount,
                controller: _paidAmountController,
                validationLabel: 'paid amount',
                isRequired: true,
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return strings.paidAmountRequired;
                  }
                  final amt = double.tryParse(v);
                  if (amt == null) return strings.enterValidAmount;
                  if (amt > _totalAmount) {
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
                    color: _dueAmount > 0
                        ? Colors.red[200]!
                        : Colors.green[200]!,
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
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submit,
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedCheckmarkCircle01,
                    color: AppColors.white,
                    size: 22,
                  ),
                  label: Text(
                    strings.createCustomOrder,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
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

  Widget _buildItemCard(int index) {
    final item = _items[index];
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            /// Image or placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: item.imageFile != null
                  ? Image.file(
                item.imageFile!,
                width: 54,
                height: 54,
                fit: BoxFit.cover,
              )
                  : Container(
                width: 54,
                height: 54,
                color: AppColors.primaryColor.withValues(alpha: 0.08),
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedDeliveryBox01,
                  size: 26,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 12),

            /// Info
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
                  const SizedBox(height: 3),
                  Text(
                    '${item.orderedQuantity} ${item.unit} × ৳${item.unitPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: AppColors.grey),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '= ৳${item.totalPrice.toStringAsFixed(2)}',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            /// Edit & delete
            Column(
              children: [
                IconButton(
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedEdit01,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                  onPressed: () => _showAddItemSheet(editIndex: index),
                  tooltip: 'Edit',
                  visualDensity: VisualDensity.compact,
                ),
                IconButton(
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedDelete03,
                    color: Colors.red,
                    size: 20,
                  ),
                  onPressed: () => _removeItem(index),
                  tooltip: 'Remove',
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ── Section header ────────────────────────────────────────────────────────────
  Widget _sectionHeader({
    required IconData icon,
    required String title,
    EdgeInsets margin = const EdgeInsets.only(bottom: 0),
  }) {
    return Padding(
      padding: margin,
      child: Row(
        children: [
          HugeIcon(icon: icon, color: AppColors.primaryColor, size: 20),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryFontColor,
            ),
          ),
        ],
      ),
    );
  }

  // ── Price row ─────────────────────────────────────────────────────────────────
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
            color: isBold ? AppColors.primaryColor : null,
          ),
        ),
      ],
    );
  }
}
