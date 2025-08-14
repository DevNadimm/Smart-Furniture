import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/hr_and_payroll/presentation/blocs/employee_list/employee_list_bloc.dart';
import 'package:smart_furniture/features/hr_and_payroll/presentation/widgets/employee_card.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';

class EmployeeListPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const EmployeeListPage());

  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<EmployeeListBloc>().add(
        LoadEmployeeListEvent(selectedShop.name),
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
        title: Text(strings!.employeeListTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<EmployeeListBloc, EmployeeListState>(
                  listener: (context, state) {
                    if (state is EmployeeListError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is EmployeeListLoading) {
                      return const Loader();
                    }
                    if (state is EmployeeListError) {
                      return const ErrorStateWidget(
                        title: 'Failed to Load Employees',
                        message: ErrorMessages.networkError,
                      );
                    }
                    if (state is EmployeeListLoaded) {
                      if (state.employeeListModel.data!.isEmpty) {
                        return const EmptyStateWidget(
                          title: 'No Employee Records Found',
                          message: 'We couldn’t find any employee records. Try adjusting your search filters or adding new employees to see them here.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.employeeListModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final employee = state.employeeListModel.data![index];
                            return EmployeeCard(employee: employee);
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
