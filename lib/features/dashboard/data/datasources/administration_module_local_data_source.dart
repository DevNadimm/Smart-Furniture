import 'package:flutter/cupertino.dart';
import 'package:smart_furniture/core/constants/image_paths.dart';
import 'package:smart_furniture/features/administration/presentation/pages/customer_list_page.dart';
import 'package:smart_furniture/features/administration/presentation/pages/damage_list_page.dart';
import 'package:smart_furniture/features/administration/presentation/pages/product_ledger_page.dart';
import 'package:smart_furniture/features/administration/presentation/pages/product_list_page.dart';
import 'package:smart_furniture/features/administration/presentation/pages/supplier_list_page.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/sub_module.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class AdministrationModuleLocalDataSource {
  static List<SubModule> getAdministrationModules(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return [
      SubModule(
        title: strings.productListTitle,
        subTitle: strings.productListSubtitle,
        iconPath: AppImages.product,
        onTap: () {
          Navigator.push(context, ProductListPage.route());
        },
      ),
      SubModule(
        title: strings.damageListTitle,
        subTitle: strings.damageListSubtitle,
        iconPath: AppImages.damage,
        onTap: () {
          Navigator.push(context, DamageListPage.route());
        },
      ),
      SubModule(
        title: strings.customerListTitle,
        subTitle: strings.customerListSubtitle,
        iconPath: AppImages.customers,
        onTap: () {
          Navigator.push(context, CustomerListPage.route());
        },
      ),
      SubModule(
        title: strings.supplierListTitle,
        subTitle: strings.supplierListSubtitle,
        iconPath: AppImages.suppliers,
        onTap: () {
          Navigator.push(context, SupplierListPage.route());
        },
      ),
      SubModule(
        title: strings.productLedgerTitle,
        subTitle: strings.productLedgerSubtitle,
        iconPath: AppImages.productLedger,
        onTap: () {
          Navigator.push(context, ProductLedgerPage.route());
        },
      ),
    ];
  }
}
