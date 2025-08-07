import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/sales_module.dart';

class SalesModuleLocalDataSource {
  static List<SubModule> getSalesModule(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return [
      SubModule(
        title: strings.salesRecordTitle,
        subTitle: strings.salesRecordSubtitle,
        iconPath: 'assets/images/modules/sales.png',
        onTap: () {
          print('Sales Record tapped');
        },
      ),
      SubModule(
        title: strings.salesReturnTitle,
        subTitle: strings.salesReturnSubtitle,
        iconPath: 'assets/images/modules/sales_return.png',
        onTap: () {
          print('Sales Return tapped');
        },
      ),
      SubModule(
        title: strings.stockTitle,
        subTitle: strings.stockSubtitle,
        iconPath: 'assets/images/modules/stock.png',
        onTap: () {
          print('Stock tapped');
        },
      ),
    ];
  }
}
