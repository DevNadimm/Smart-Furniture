import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/summary_card.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/supplier_dues/supplier_dues_bloc.dart';
import 'package:smart_furniture/features/admin/presentation/widgets/supplier_due_card.dart';

class SupplierDuesPage extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const SupplierDuesPage());

  const SupplierDuesPage({super.key});

  @override
  State<SupplierDuesPage> createState() => _SupplierDuesPageState();
}

class _SupplierDuesPageState extends State<SupplierDuesPage> {
  @override
  void initState() {
    super.initState();
    _fetchSupplierDues();
  }

  void _fetchSupplierDues() {
    context.read<SupplierDuesBloc>().add(LoadSupplierDuesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplier Dues'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchSupplierDues,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocConsumer<SupplierDuesBloc, SupplierDuesState>(
        listener: (context, state) {
          if (state is SupplierDuesError) {
            AppNotifier.showToast(state.message, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is SupplierDuesLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Loader(),
            );
          }

          if (state is SupplierDuesError) {
            return const ErrorStateWidget(
              title: 'Failed to Load Supplier Dues',
              message: ErrorMessages.networkError,
            );
          }

          if (state is SupplierDuesLoaded) {
            if (state.supplierDuesModel.data?.isEmpty ?? true) {
              return const EmptyStateWidget(
                title: 'No Supplier Dues Found',
                message: 'Currently no supplier has any pending dues.',
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SummaryCard(
                      amount: state.supplierDuesModel.totalDues?.toDouble() ?? 0.0,
                      amountLabel: 'Total Dues',
                      quantity: state.supplierDuesModel.totalSuppliers ?? 0,
                      quantityLabel: 'Total Suppliers',
                    ),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.supplierDuesModel.data!.length,
                    itemBuilder: (context, index) {
                      return SupplierDueCard(
                        supplierDue: state.supplierDuesModel.data![index],
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