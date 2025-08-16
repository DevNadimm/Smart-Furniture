import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/dashboard/data/datasources/reports_module_local_data_source.dart';
import 'package:smart_furniture/features/dashboard/presentation/widgets/sub_module_tile.dart';

class ReportsModulePage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const ReportsModulePage());

  const ReportsModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final reportsModule = ReportsModuleLocalDataSource.getReportsModules(context);
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.reports),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.separated(
          itemCount: reportsModule.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final module = reportsModule[index];
            return SubModuleTile(module: module);
          },
        ),
      ),
    );
  }
}
