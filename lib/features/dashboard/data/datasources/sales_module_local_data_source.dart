import 'package:flutter/cupertino.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/sub_module.dart';
import 'package:smart_furniture/features/sales/presentation/pages/sales_record_page.dart';
import 'package:smart_furniture/features/sales/presentation/pages/sales_return_page.dart';
import 'package:smart_furniture/features/sales/presentation/pages/stock_page.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class SalesModuleLocalDataSource {
  static List<SubModule> getSalesModules(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return [
      SubModule(
        title: strings.salesRecordTitle,
        subTitle: strings.salesRecordSubtitle,
        iconPath: 'assets/images/modules/sales.png',
        onTap: () {
          Navigator.push(context, SalesRecordPage.route());
        },
      ),
      SubModule(
        title: strings.salesReturnTitle,
        subTitle: strings.salesReturnSubtitle,
        iconPath: 'assets/images/modules/sales_return.png',
        onTap: () {
          Navigator.push(context, SalesReturnPage.route());
        },
      ),
      SubModule(
        title: strings.stockTitle,
        subTitle: strings.stockSubtitle,
        iconPath: 'assets/images/modules/stock.png',
        onTap: () {
          Navigator.push(context, StockPage.route());
        },
      ),
    ];
  }
}
