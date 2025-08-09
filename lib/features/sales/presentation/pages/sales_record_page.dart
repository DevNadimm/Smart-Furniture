import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/empty_state_widget.dart';
import 'package:smart_furniture/core/utils/widgets/loader.dart';
import 'package:smart_furniture/features/sales/presentation/bloc/sales_record_bloc.dart';
import 'package:smart_furniture/features/sales/presentation/widgets/sales_record_card.dart';

class SalesRecordPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const SalesRecordPage());

  const SalesRecordPage({super.key});

  @override
  State<SalesRecordPage> createState() => _SalesRecordPageState();
}

class _SalesRecordPageState extends State<SalesRecordPage> {
  @override
  void initState() {
    _fetchData();
    super.initState();
  }

  void _fetchData() {
    context.read<SalesRecordBloc>().add(LoadSalesRecordEvent(fromDate: '', toDate: ''));
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings!.salesRecordTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: BlocConsumer<SalesRecordBloc, SalesRecordState>(
            listener: (context, state) {
              if (state is SalesRecordError) {
                AppNotifier.showSnackBar(context, state.message);
              }
            },
            builder: (context, state) {
              if (state is SalesRecordLoading) {
                return const Loader();
              }
              if (state is SalesRecordLoaded) {
                if (state.salesRecord!.isEmpty) {
                  return const EmptyStateWidget(
                    title: 'No Sales Records Found',
                    message: 'We couldn’t find any sales records for the selected date range. Try adjusting your filters or selecting a different time period.',
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.salesRecord?.length ?? 0,
                    itemBuilder: (context, index) {
                      final record = state.salesRecord?[index];
                      return SalesRecordCard(salesRecord: record);
                    },
                  );
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
