import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/core/constants/error_messages.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/error_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/hr_and_payroll/presentation/blocs/salary_payment/salary_payment_bloc.dart';
import 'package:smart_furniture/features/hr_and_payroll/presentation/widgets/salary_payment_card.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';

class SalaryPaymentPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const SalaryPaymentPage());

  const SalaryPaymentPage({super.key});

  @override
  State<SalaryPaymentPage> createState() => _SalaryPaymentPageState();
}

class _SalaryPaymentPageState extends State<SalaryPaymentPage> {

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    final selectedShop = context.read<ShopSelectionCubit>().state;
    if (selectedShop != null) {
      context.read<SalaryPaymentBloc>().add(
        LoadSalaryPaymentEvent(selectedShop.name),
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
        title: Text(strings!.salaryPaymentTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: BlocConsumer<SalaryPaymentBloc, SalaryPaymentState>(
                  listener: (context, state) {
                    if (state is SalaryPaymentError) {
                      AppNotifier.showToast(state.message, type: MessageType.error);
                    }
                  },
                  builder: (context, state) {
                    if (state is SalaryPaymentLoading) {
                      return const Loader();
                    }
                    if (state is SalaryPaymentError) {
                      return const ErrorStateWidget(
                        title: 'Failed to Load Salary Payment Records',
                        message: ErrorMessages.networkError,
                      );
                    }
                    if (state is SalaryPaymentLoaded) {
                      if (state.salaryPaymentModel.data?.isEmpty ?? true) {
                        return const EmptyStateWidget(
                          title: 'No Salary Payment Records Found',
                          message: 'We couldn’t find any salary payment records for the selected date range. Try adjusting your filters or selecting a different time period.',
                        );
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.salaryPaymentModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final salaryPaymentData = state.salaryPaymentModel.data?[index];
                            return SalaryPaymentCard(salaryPaymentData: salaryPaymentData);
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
