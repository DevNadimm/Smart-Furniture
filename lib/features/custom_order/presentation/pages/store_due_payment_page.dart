import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/formatters/currency_formatter.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/custom_text_field.dart';
import 'package:smart_furniture/core/utils/widgets/searchable_bottom_sheet.dart';
import 'package:smart_furniture/features/custom_order/presentation/blocs/store_due_payment/store_due_payment_bloc.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class CustomOrderDuePaymentPage extends StatefulWidget {
  final int orderId;
  final String orderNo;
  final num dueAmount;

  static Route route({
    required int orderId,
    required String orderNo,
    required num dueAmount,
  }) =>
      MaterialPageRoute(
        builder: (_) => CustomOrderDuePaymentPage(
          orderId: orderId,
          orderNo: orderNo,
          dueAmount: dueAmount,
        ),
      );

  const CustomOrderDuePaymentPage({
    super.key,
    required this.orderId,
    required this.orderNo,
    required this.dueAmount,
  });

  @override
  State<CustomOrderDuePaymentPage> createState() =>
      _CustomOrderDuePaymentPageState();
}

class _CustomOrderDuePaymentPageState
    extends State<CustomOrderDuePaymentPage> {
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
    _paymentDateController.text =
        DateFormat('yyyy-MM-dd').format(_selectedDate);
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
        _paymentDateController.text =
            DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void _selectPaymentTypePicker() {
    final strings = AppLocalizations.of(context)!;
    showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (_) {
        return SearchableBottomSheet(
          items: _paymentTypes,
          title: strings.selectPaymentTypeTitle,
          subtitle: strings.selectPaymentTypeSubtitle,
          searchHint: strings.searchPaymentType,
          selectedItem: _paymentTypeController.text,
          onItemSelected: (String selected) {
            setState(() {
              _paymentTypeController.text = selected;
            });
          },
        );
      },
    );
  }

  void _submitPayment() {
    if (!_formKey.currentState!.validate()) return;

    final body = {
      'order_id': widget.orderId,
      'payment_date': _paymentDateController.text,
      'amount': double.parse(_amountController.text),
      'payment_type': _paymentTypeController.text,
      'transaction_id': _transactionIdController.text.isEmpty
          ? null
          : _transactionIdController.text,
    };

    context
        .read<StoreDuePaymentBloc>()
        .add(StoreDuePaymentSubmitEvent(body));
  }

  String _calculateRemainingDue() {
    final paying = double.tryParse(_amountController.text) ?? 0;
    final remaining = widget.dueAmount.toDouble() - paying;
    return remaining < 0 ? '0.00' : remaining.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return BlocConsumer<StoreDuePaymentBloc, StoreDuePaymentState>(
      listener: (context, state) {
        if (state is StoreDuePaymentError) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        } else if (state is StoreDuePaymentSuccess) {
          AppNotifier.showToast(state.message, type: MessageType.success);
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            _buildContent(strings),
            if (state is StoreDuePaymentLoading)
              Container(
                height: double.infinity,
                width: double.infinity,
                color: AppColors.black.withValues(alpha: 0.6),
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.white),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildContent(AppLocalizations strings) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.customOrderDuePayment),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Order Info Card
              _buildOrderInfoCard(strings),
              const SizedBox(height: 24),

              /// Payment Date
              CustomTextField(
                label: strings.paymentDate,
                hintText: strings.selectPaymentDate,
                controller: _paymentDateController,
                validationLabel: 'payment date',
                isRequired: true,
                readOnly: true,
                onTap: _selectDate,
              ),
              const SizedBox(height: 16),

              /// Payment Amount
              CustomTextField(
                label: strings.paymentAmount,
                controller: _amountController,
                validationLabel: 'payment amount',
                isRequired: true,
                keyboardType: TextInputType.number,
                onChanged: (_) => setState(() {}),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return strings.paymentAmountRequired;
                  }
                  final amount = double.tryParse(value);
                  if (amount == null) {
                    return strings.enterValidAmount;
                  }
                  if (amount <= 0) {
                    return strings.amountGreaterThanZero;
                  }
                  if (amount > widget.dueAmount) {
                    return strings.amountCannotExceedDue;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              /// Payment Type
              CustomTextField(
                label: strings.paymentType,
                hintText: strings.selectPaymentType,
                controller: _paymentTypeController,
                validationLabel: 'payment type',
                isRequired: true,
                readOnly: true,
                onTap: _selectPaymentTypePicker,
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
              const SizedBox(height: 16),

              /// Transaction ID (optional)
              CustomTextField(
                label: strings.transactionId,
                controller: _transactionIdController,
                validationLabel: 'transaction ID',
                hintText: strings.transactionIdHint,
                maxLines: 2,
              ),
              const SizedBox(height: 24),

              /// Payment Summary Card
              _buildPaymentSummaryCard(strings),
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
                    strings.submitPayment,
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

  /// ── Order Info Card ────────────────────────────────────────────────────────
  Widget _buildOrderInfoCard(AppLocalizations strings) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderColor, width: 1),
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
                      strings.orderInformation,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.orderNo,
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
                strings.dueAmount,
                style: GoogleFonts.poppins(
                    fontSize: 14, color: AppColors.grey),
              ),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '৳${CurrencyFormatter.format(widget.dueAmount, context: context)}',
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

  /// ── Payment Summary Card ───────────────────────────────────────────────────
  Widget _buildPaymentSummaryCard(AppLocalizations strings) {
    return Container(
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
          _buildSummaryRow(
            label: strings.totalDue,
            value:
            '৳${CurrencyFormatter.format(widget.dueAmount, context: context)}',
          ),
          const SizedBox(height: 8),
          _buildSummaryRow(
            label: strings.payingAmount,
            value:
            '৳${CurrencyFormatter.format(num.tryParse(_amountController.text), context: context)}',
          ),
          const Divider(height: 24, thickness: 1, color: Colors.white24),
          _buildSummaryRow(
            label: strings.remainingDue,
            value:
            '৳${CurrencyFormatter.format(num.tryParse(_calculateRemainingDue()), context: context)}',
            isBold: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required String value,
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: isBold ? 16 : 14,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: AppColors.white,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: isBold ? 18 : 14,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}