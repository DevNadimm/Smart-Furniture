import 'package:flutter/material.dart';
import 'package:smart_furniture/features/dashboard/data/datasources/purchase_module_local_data_source.dart';
import 'package:smart_furniture/features/dashboard/presentation/widgets/sub_module_tile.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class PurchaseModulePage extends StatelessWidget {
  static Route route() => MaterialPageRoute(builder: (context) => const PurchaseModulePage());

  const PurchaseModulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final purchaseModules = PurchaseModuleLocalDataSource.getPurchaseModules(context);
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.purchase),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.separated(
          itemCount: purchaseModules.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final module = purchaseModules[index];
            return SubModuleTile(module: module);
          },
        ),
      ),
    );
  }
}
