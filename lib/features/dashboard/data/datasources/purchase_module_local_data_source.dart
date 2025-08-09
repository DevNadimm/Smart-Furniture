import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/sales_module.dart';

class PurchaseModuleLocalDataSource {
  static List<SubModule> getPurchaseModules(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return [
      SubModule(
        title: strings.purchaseRecordTitle,
        subTitle: strings.purchaseRecordSubtitle,
        iconPath: 'assets/images/modules/purchase.png',
        onTap: () {},
      ),
      SubModule(
        title: strings.purchaseReturnTitle,
        subTitle: strings.purchaseReturnSubtitle,
        iconPath: 'assets/images/modules/sales_return.png',
        onTap: () {},
      ),
    ];
  }
}
