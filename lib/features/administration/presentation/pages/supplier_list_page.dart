import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/supplier_list/supplier_list_bloc.dart';
import 'package:smart_furniture/features/administration/presentation/widgets/supplier_card.dart';

class SupplierListPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const SupplierListPage());

  const SupplierListPage({super.key});

  @override
  State<SupplierListPage> createState() => _SupplierListPageState();
}

class _SupplierListPageState extends State<SupplierListPage> {

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    context.read<SupplierListBloc>().add(
      LoadSupplierListEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings!.supplierListTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<SupplierListBloc, SupplierListState>(
                  listener: (context, state) {
                    if (state is SupplierListError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is SupplierListLoading) {
                      return const Loader();
                    }
                    if (state is SupplierListLoaded) {
                      if (state.supplierListModel.data!.isEmpty) {
                        return const EmptyStateWidget(
                          title: 'No Supplier Records Found',
                          message: 'We couldn’t find any supplier records. Try adjusting your search filters or adding new suppliers to see them here.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.supplierListModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final supplier = state.supplierListModel.data![index];
                            return SupplierCard(supplier: supplier);
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
