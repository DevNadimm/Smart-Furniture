import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/custom_text_field.dart';
import 'package:smart_furniture/features/employee_dashboard/data/models/customer_model.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/customer/customer_bloc.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class EditCustomerPage extends StatefulWidget {
  static Route route({required CustomerData customer}) => MaterialPageRoute(builder: (_) => EditCustomerPage(customer: customer));
  final CustomerData customer;

  const EditCustomerPage({super.key, required this.customer});

  @override
  State<EditCustomerPage> createState() => _EditCustomerPageState();
}

class _EditCustomerPageState extends State<EditCustomerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nameBnController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.customer.name ?? '';
    _nameBnController.text = widget.customer.nameBn ?? '';
    _phoneController.text = widget.customer.phone ?? '';
    _emailController.text = widget.customer.email ?? '';
    _addressController.text = widget.customer.address ?? '';
  }

  void _editCustomer() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final customerData = {
      'name': _nameController.text,
      'name_bn': _nameBnController.text.isEmpty ? null : _nameBnController.text,
      'phone': _phoneController.text,
      'email': _emailController.text.isEmpty ? null : _emailController.text,
      'address': _addressController.text.isEmpty ? null : _addressController.text,
    };

    context.read<CustomerBloc>().add(UpdateCustomerEvent(widget.customer.id!, customerData));
    print('Customer Data: $customerData');
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return BlocConsumer<CustomerBloc, CustomerState>(
      listener: (context, state) {
        if (state is CustomerError) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        } else if (state is CustomerOperationSuccess) {
          AppNotifier.showToast(strings.customerEditedSuccess, type: MessageType.success);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            _content(strings),
            if (state is CustomerOperationLoading)
              Container(
                height: double.infinity,
                width: double.infinity,
                color: AppColors.black.withValues(alpha: 0.6),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.white,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _content(AppLocalizations strings) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.editCustomer),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  label: strings.name,
                  hintText: strings.enterCustomerName,
                  controller: _nameController,
                  validationLabel: 'Name',
                  isRequired: true,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: strings.nameBangla,
                  hintText: strings.enterCustomerNameBangla,
                  controller: _nameBnController,
                  validationLabel: 'Name (Bangla)',
                  isRequired: false,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: strings.phone,
                  hintText: strings.enterPhoneNumber,
                  controller: _phoneController,
                  validationLabel: 'Phone',
                  isRequired: true,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: strings.email,
                  hintText: strings.enterEmailAddress,
                  controller: _emailController,
                  validationLabel: 'Email',
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: strings.address,
                  hintText: strings.enterAddress,
                  controller: _addressController,
                  validationLabel: 'Address',
                  isRequired: true,
                  keyboardType: TextInputType.streetAddress,
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _editCustomer,
                    child: Text(strings.editCustomer),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameBnController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}