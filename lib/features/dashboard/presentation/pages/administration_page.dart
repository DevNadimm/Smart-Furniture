import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/dashboard/data/datasources/administration_module_local_data_source.dart';
import 'package:smart_furniture/features/dashboard/presentation/widgets/sub_module_tile.dart';

class AdministrationModulePage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const AdministrationModulePage());

  const AdministrationModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final administrationModules = AdministrationModuleLocalDataSource.getAdministrationModules(context);
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.administration),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.separated(
          itemCount: administrationModules.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final module = administrationModules[index];
            return SubModuleTile(module: module);
          },
        ),
      ),
    );
  }
}
