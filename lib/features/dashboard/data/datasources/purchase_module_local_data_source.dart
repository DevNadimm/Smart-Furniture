import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/sub_module.dart';
import 'package:smart_furniture/features/purchase/presentation/pages/purchase_record_page.dart';
import 'package:smart_furniture/features/purchase/presentation/pages/purchase_return_page.dart';

class PurchaseModuleLocalDataSource {
  static List<SubModule> getPurchaseModules(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return [
      SubModule(
        title: strings.purchaseRecordTitle,
        subTitle: strings.purchaseRecordSubtitle,
        iconPath: 'assets/images/modules/purchase.png',
        onTap: () {
          Navigator.push(context, PurchaseRecordPage.route());
        },
      ),
      SubModule(
        title: strings.purchaseReturnTitle,
        subTitle: strings.purchaseReturnSubtitle,
        iconPath: 'assets/images/modules/sales_return.png',
        onTap: () {
          Navigator.push(context, PurchaseReturnPage.route());
        },
      ),
    ];
  }
}
