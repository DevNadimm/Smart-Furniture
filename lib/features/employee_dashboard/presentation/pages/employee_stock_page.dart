import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/blocs/stock/employee_stock_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/widgets/employee_stock_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class EmployeeStockPage extends StatefulWidget {
  static Route route({bool? isAdmin, int? branchId}) => MaterialPageRoute(builder: (_) => EmployeeStockPage(isAdmin: isAdmin ?? false, branchId: branchId));

  final bool isAdmin;
  final int? branchId;

  const EmployeeStockPage({super.key, required this.isAdmin, this.branchId});

  @override
  State<EmployeeStockPage> createState() => _EmployeeStockPageState();
}

class _EmployeeStockPageState extends State<EmployeeStockPage> {
  @override
  void initState() {
    super.initState();
    _fetchStock();
  }

  void _fetchStock() {
    context.read<EmployeeStockBloc>().add(LoadStocksEvent(branchId: widget.branchId));
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.stock),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<EmployeeStockBloc, EmployeeStockState>(
          listener: (context, state) {
            if (state is StockError) {
              AppNotifier.showToast(state.message, type: MessageType.error);
            }
          },
          builder: (context, state) {
            if (state is StockLoading) {
              return const Loader();
            }

            if (state is StockError) {
              return const ErrorStateWidget(
                title: 'Failed to Load Stock',
                message: ErrorMessages.networkError,
              );
            }

            if (state is StockLoaded) {
              if (state.stockModel.data?.isEmpty ?? true) {
                return const EmptyStateWidget(
                  title: 'No Stock Found',
                  message: 'Currently no stock information is available.',
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: state.stockModel.data!.length,
                itemBuilder: (context, index) {
                  return EmployeeStockCard(
                    stock: state.stockModel.data![index],
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
