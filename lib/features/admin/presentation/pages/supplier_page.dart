import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/summary_card.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/supplier/supplier_bloc.dart';
import 'package:smart_furniture/features/admin/presentation/widgets/supplier_card.dart';

class SupplierPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const SupplierPage());

  const SupplierPage({super.key});

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {
  @override
  void initState() {
    super.initState();
    _fetchSuppliers();
  }

  void _fetchSuppliers() {
    context.read<SupplierBloc>().add(LoadSuppliersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suppliers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchSuppliers,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocConsumer<SupplierBloc, SupplierState>(
        listener: (context, state) {
          if (state is SupplierError) {
            AppNotifier.showToast(state.message, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is SupplierLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Loader(),
            );
          }

          if (state is SupplierError) {
            return const ErrorStateWidget(
              title: 'Failed to Load Suppliers',
              message: ErrorMessages.networkError,
            );
          }

          if (state is SupplierLoaded) {
            if (state.suppliers.isEmpty) {
              return const EmptyStateWidget(
                title: 'No Suppliers Found',
                message: 'Currently no supplier records are available.',
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.suppliers.length,
                    itemBuilder: (context, index) {
                      return SupplierCard(
                        supplier: state.suppliers[index],
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   SupplierDetailsPage.route(
                          //     supplierId: state.suppliers[index].id ?? 0,
                          //   ),
                          // );
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
    );
  }
}