import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/dashboard/data/datasources/sales_module_local_data_source.dart';
import 'package:smart_furniture/features/dashboard/presentation/widgets/sub_module_tile.dart';

class SalesModulePage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const SalesModulePage());

  const SalesModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final salesModules = SalesModuleLocalDataSource.getSalesModule(context);
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.sales),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.separated(
          itemCount: salesModules.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final module = salesModules[index];
            return SalesModuleTile(module: module);
          },
        ),
      ),
    );
  }
}
