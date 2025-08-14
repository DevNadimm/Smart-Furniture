import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/accounts/presentation/blocs/pending_cheque_list/pending_cheque_list_bloc.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';

class PendingChequeListPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const PendingChequeListPage());

  const PendingChequeListPage({super.key});

  @override
  State<PendingChequeListPage> createState() => _PendingChequeListPageState();
}

class _PendingChequeListPageState extends State<PendingChequeListPage> {

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<PendingChequeListBloc>().add(
        LoadPendingChequeListEvent(selectedShop.name),
      );
    } else {
      AppNotifier.showToast(ErrorMessages.unknownError, type: MessageType.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings!.pendingChequeListTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<PendingChequeListBloc, PendingChequeListState>(
                  listener: (context, state) {
                    if (state is PendingChequeListError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is PendingChequeListLoading) {
                      return const Loader();
                    }
                    if (state is PendingChequeListError) {
                      return const ErrorStateWidget(
                        title: 'Failed to Load Pending Cheques',
                        message: ErrorMessages.networkError,
                      );
                    }
                    if (state is PendingChequeListLoaded) {
                      if (state.pendingChequeListModel.data!.isEmpty) {
                        return const EmptyStateWidget(
                          title: 'No Pending Cheques Found',
                          message: 'There are currently no pending cheques available.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.pendingChequeListModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final pendingCheck = state.pendingChequeListModel.data![index];
                            return Text(pendingCheck.bankName ?? 'N/A');
                          },
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
