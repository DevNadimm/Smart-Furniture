import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/core/utils/widgets/summary_card.dart';
import 'package:smart_furniture/features/admin/presentation/blocs/purchase/purchase_bloc.dart';
import 'package:smart_furniture/features/admin/presentation/pages/purchase_details_page.dart';
import 'package:smart_furniture/features/admin/presentation/widgets/purchase_card.dart';

class PurchasePage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const PurchasePage());

  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  @override
  void initState() {
    super.initState();
    _fetchPurchases();
  }

  void _fetchPurchases() {
    context.read<PurchaseBloc>().add(LoadPurchasesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purchases'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchPurchases,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: BlocConsumer<PurchaseBloc, PurchaseState>(
        listener: (context, state) {
          if (state is PurchaseError) {
            AppNotifier.showToast(state.message, type: MessageType.error);
          }
        },
        builder: (context, state) {
          if (state is PurchaseLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Loader(),
            );
          }

          if (state is PurchaseError) {
            return const ErrorStateWidget(
              title: 'Failed to Load Purchases',
              message: ErrorMessages.networkError,
            );
          }

          if (state is PurchaseLoaded) {
            if (state.purchases.purchases?.isEmpty ?? true) {
              return const EmptyStateWidget(
                title: 'No Purchases Found',
                message: 'Currently no purchase records are available.',
              );
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SummaryCard(amount: state.purchases.summary?.totalAmount?.toDouble() ?? 0.0, amountLabel: 'Total Amount', quantity: state.purchases.summary?.totalPurchases ?? 0, quantityLabel: 'Total Purchases'),
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.purchases.purchases?.length ?? 0,
                    itemBuilder: (context, index) {
                      return PurchaseCard(
                        purchase: state.purchases.purchases![index],
                        onTap: () {
                          Navigator.push(
                            context,
                            PurchaseDetailsPage.route(
                              purchaseId: state.purchases.purchases?[index].id ?? 0,
                            ),
                          );
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