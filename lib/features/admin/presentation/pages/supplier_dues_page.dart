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
import 'package:smart_furniture/l10n/app_localizations.dart';

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
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.supplierDues),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchSupplierDues,
            tooltip: strings.refresh,
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
            return ErrorStateWidget(
              title: strings.supplierDuesLoadError,
              message: ErrorMessages.networkError,
            );
          }

          if (state is SupplierDuesLoaded) {
            if (state.supplierDuesModel.data?.isEmpty ?? true) {
              return EmptyStateWidget(
                title: strings.noSupplierDuesFound,
                message: strings.noSupplierDuesMessage,
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: SummaryCard(
                      amount: state.supplierDuesModel.totalDues?.toDouble() ?? 0.0,
                      amountLabel: strings.totalDues,
                      quantity: state.supplierDuesModel.totalSuppliers ?? 0,
                      quantityLabel: strings.totalSuppliers,
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