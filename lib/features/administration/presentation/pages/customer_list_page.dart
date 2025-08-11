import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/administration/presentation/blocs/customer_list/customer_list_bloc.dart';
import 'package:smart_furniture/features/administration/presentation/widgets/customer_card.dart';

class CustomerListPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const CustomerListPage());

  const CustomerListPage({super.key});

  @override
  State<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    context.read<CustomerListBloc>().add(
      LoadCustomerListEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings!.customerListTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<CustomerListBloc, CustomerListState>(
                  listener: (context, state) {
                    if (state is CustomerListError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is CustomerListLoading) {
                      return const Loader();
                    }
                    if (state is CustomerListLoaded) {
                      if (state.customerListModel.data!.isEmpty) {
                        return const EmptyStateWidget(
                          title: 'No Customer Records Found',
                          message: 'We couldn’t find any customer records. Try adjusting your search filters or adding new customers to see them here.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.customerListModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final customer = state.customerListModel.data![index];
                            return CustomerCard(customer: customer);
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
