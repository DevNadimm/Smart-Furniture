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
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/due_payment/due_payment_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/customer_purchase_dues/customer_purchase_dues_bloc.dart';

class DuePaymentPage extends StatefulWidget {
  final int customerId;
  final int saleId;
  final String saleNo;
  final int dueAmount;

  static Route route({
    required int customerId,
    required int saleId,
    required String saleNo,
    required int dueAmount,
  }) =>
      MaterialPageRoute(
        builder: (_) => DuePaymentPage(
          customerId: customerId,
          saleId: saleId,
          saleNo: saleNo,
          dueAmount: dueAmount,
        ),
      );

  const DuePaymentPage({
    super.key,
    required this.customerId,
    required this.saleId,
    required this.saleNo,
    required this.dueAmount,
  });

  @override
  State<DuePaymentPage> createState() => _DuePaymentPageState();
}

class _DuePaymentPageState extends State<DuePaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _paymentDateController = TextEditingController();
  final _amountController = TextEditingController();
  final _paymentTypeController = TextEditingController();
  final _transactionIdController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  final List<String> _paymentTypes = [
    'Cash',
    'QR Code',
    'Debit/Credit Cards',
    'Digital Wallet',
  ];

  @override
  void initState() {
    super.initState();
    _paymentDateController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
    _amountController.text = widget.dueAmount.toString();
  }

  @override
  void dispose() {
    _paymentDateController.dispose();
    _amountController.dispose();
    _paymentTypeController.dispose();
    _transactionIdController.dispose();
    super.dispose();
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
        _paymentDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
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

  void _submitPayment() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final paymentData = {
      'sale_id': widget.saleId,
      'payment_date': _paymentDateController.text,
      'amount': double.parse(_amountController.text),
      'payment_type': _paymentTypeController.text,
      'transaction_id': _transactionIdController.text.isEmpty
          ? null
          : _transactionIdController.text,
    };

    context.read<DuePaymentBloc>().add(MakeDuePaymentEvent(paymentData));
    print('Payment Data: $paymentData');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DuePaymentBloc, DuePaymentState>(
      listener: (context, state) {
        if (state is DuePaymentError) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        } else if (state is DuePaymentSuccess) {
          AppNotifier.showToast(state.message, type: MessageType.success);
          // Refresh the purchase dues page
          context.read<CustomerPurchaseDuesBloc>().add(
            LoadCustomerPurchaseDuesEvent(widget.customerId),
          );
          // Reset payment bloc and go back
          context.read<DuePaymentBloc>().add(ResetDuePaymentEvent());
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            _content(),
            if (state is DuePaymentLoading)
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
  }

  Widget _content() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Due Payment'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Sale Information Card
              _buildSaleInfoCard(),
              const SizedBox(height: 24),

              /// Payment Date
              CustomTextField(
                label: 'Payment Date',
                hintText: 'Select payment date',
                controller: _paymentDateController,
                validationLabel: 'payment date',
                isRequired: true,
                readOnly: true,
                onTap: _selectDate,
              ),
              const SizedBox(height: 16),

              /// Payment Amount
              CustomTextField(
                label: 'Payment Amount',
                controller: _amountController,
                validationLabel: 'payment amount',
                isRequired: true,
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Payment amount is required';
                  }
                  final amount = double.tryParse(value);
                  if (amount == null) {
                    return 'Enter a valid amount';
                  }
                  if (amount <= 0) {
                    return 'Amount must be greater than 0';
                  }
                  if (amount > widget.dueAmount) {
                    return 'Amount cannot exceed due amount';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              /// Payment Type
              CustomTextField(
                label: 'Payment Type',
                hintText: 'Select payment type',
                controller: _paymentTypeController,
                validationLabel: 'payment type',
                isRequired: true,
                readOnly: true,
                onTap: () => _selectPaymentTypePicker(_paymentTypes),
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
              const SizedBox(height: 16),

              /// Transaction ID
              CustomTextField(
                label: 'Transaction ID',
                controller: _transactionIdController,
                validationLabel: 'transaction ID',
                hintText: 'Transaction ID, Reference, etc. (Optional)',
                maxLines: 2,
              ),
              const SizedBox(height: 24),

              /// Payment Summary Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primaryColor,
                      AppColors.primaryColor.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Due',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          '৳${widget.dueAmount}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Paying Amount',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          '৳${_amountController.text.isEmpty ? '0' : _amountController.text}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 24,
                      thickness: 1,
                      color: Colors.white24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Remaining Due',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                        Text(
                          '৳${_calculateRemainingDue()}',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              /// Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitPayment,
                  icon: const HugeIcon(
                    icon: HugeIcons.strokeRoundedWallet01,
                    color: AppColors.white,
                    size: 22,
                  ),
                  label: Text(
                    'Submit Payment',
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

  Widget _buildSaleInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: AppColors.borderColor,
          width: 1,
        ),
      ),
      child: Column(
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
                child: const HugeIcon(
                  icon: HugeIcons.strokeRoundedReceiptDollar,
                  color: AppColors.primaryColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sale Information',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.saleNo,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryFontColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.borderColor),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Due Amount',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: AppColors.grey,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '৳${widget.dueAmount}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _calculateRemainingDue() {
    final payingAmount = double.tryParse(_amountController.text) ?? 0;
    final remaining = widget.dueAmount - payingAmount;
    return remaining.toStringAsFixed(2);
  }
}