import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/custom_text_field.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/customer/customer_bloc.dart';

class CreateCustomerPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const CreateCustomerPage());

  const CreateCustomerPage({super.key});

  @override
  State<CreateCustomerPage> createState() => _CreateCustomerPageState();
}

class _CreateCustomerPageState extends State<CreateCustomerPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nameBnController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  void _createCustomer() {
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

    context.read<CustomerBloc>().add(CreateCustomerEvent(customerData));
    print('Customer Data: $customerData');
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CustomerBloc, CustomerState>(
      listener: (context, state) {
        if (state is CustomerError) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        } else if (state is CustomerOperationSuccess) {
          AppNotifier.showToast('Customer created successfully', type: MessageType.success);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            _content(),
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

  Widget _content() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Customer'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  label: 'Name',
                  hintText: 'Enter customer name',
                  controller: _nameController,
                  validationLabel: 'Name',
                  isRequired: true,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Name (Bangla)',
                  hintText: 'Enter customer name in Bangla',
                  controller: _nameBnController,
                  validationLabel: 'Name (Bangla)',
                  isRequired: false,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Phone',
                  hintText: 'Enter phone number',
                  controller: _phoneController,
                  validationLabel: 'Phone',
                  isRequired: true,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Email',
                  hintText: 'Enter email address',
                  controller: _emailController,
                  validationLabel: 'Email',
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Address',
                  hintText: 'Enter address',
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
                    onPressed: _createCustomer,
                    child: const Text('Create Customer'),
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