import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/summary_card.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/customer_dues/customer_dues_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/widgets/customer_due_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class CustomerDuesPage extends StatefulWidget {
  static Route route({int? branchId, bool? isAdmin}) => MaterialPageRoute(builder: (_) => CustomerDuesPage(branchId: branchId, isAdmin: isAdmin,));

  final int? branchId;
  final bool? isAdmin;

  const CustomerDuesPage({super.key, this.branchId, this.isAdmin = false});

  @override
  State<CustomerDuesPage> createState() => _CustomerDuesPageState();
}

class _CustomerDuesPageState extends State<CustomerDuesPage> {
  @override
  void initState() {
    super.initState();
    _fetchCustomerDues();
  }

  void _fetchCustomerDues() {
    context.read<CustomerDuesBloc>().add(LoadCustomerDuesEvent(branchId: widget.branchId));
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.customerDues),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchCustomerDues,
            tooltip: strings.refresh,
          ),
        ],
      ),
      body: BlocConsumer<CustomerDuesBloc, CustomerDuesState>(
        listener: (context, state) {
          if (state is CustomerDuesError) {
            AppNotifier.showToast(state.message, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is CustomerDuesLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Loader(),
            );
          }

          if (state is CustomerDuesError) {
            return ErrorStateWidget(
              title: strings.failedToLoadCustomerDues,
              message: ErrorMessages.networkError,
            );
          }

          if (state is CustomerDuesLoaded) {
            if (state.customerDuesModel.data?.isEmpty ?? true) {
              return EmptyStateWidget(
                title: strings.noCustomerDuesFound,
                message: strings.noCustomerDuesMessage,
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SummaryCard(
                      amount: state.customerDuesModel.totalDues?.toDouble() ?? 0.0,
                      amountLabel: strings.totalDues,
                      quantity: state.customerDuesModel.totalCustomers ?? 0,
                      quantityLabel: strings.totalCustomers,
                    ),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.customerDuesModel.data!.length,
                    itemBuilder: (context, index) {
                      return CustomerDueCard(
                        customerDue: state.customerDuesModel.data![index],
                        isAdmin: widget.isAdmin,
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