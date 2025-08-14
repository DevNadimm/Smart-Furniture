import 'package:flutter/cupertino.dart';
import 'package:smart_furniture/core/constants/image_paths.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/module.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/dashboard/presentation/pages/administration_module_page.dart';
import 'package:smart_furniture/features/dashboard/presentation/pages/hr_module_page.dart';
import 'package:smart_furniture/features/dashboard/presentation/pages/purchase_module_page.dart';
import 'package:smart_furniture/features/dashboard/presentation/pages/sales_module_page.dart';
import 'package:smart_furniture/features/shop_selector/presentation/pages/shop_selection_page.dart';

class ModuleLocalDataSource {
  static List<Module> getModules(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return [
      Module(
        title: strings.purchase,
        subTitle: strings.purchaseSubTitle,
        iconPath: AppImages.purchase,
        onTap: () {
          Navigator.push(context, PurchaseModulePage.route());
        },
      ),
      Module(
        title: strings.sales,
        subTitle: strings.salesSubTitle,
        iconPath: AppImages.sales,
        onTap: () {
          Navigator.push(context, SalesModulePage.route());
        },
      ),
      Module(
        title: strings.accounts,
        subTitle: strings.accountsSubTitle,
        iconPath: AppImages.accounts,
        onTap: () {
          // Navigate to Accounts Page
        },
      ),
      Module(
        title: strings.administration,
        subTitle: strings.administrationSubTitle,
        iconPath: AppImages.administration,
        onTap: () {
          Navigator.push(context, AdministrationModulePage.route());
        },
      ),
      Module(
        title: strings.hr,
        subTitle: strings.hrSubTitle,
        iconPath: AppImages.hr,
        onTap: () {
          Navigator.push(context, HrModulePage.route());
        },
      ),
      Module(
        title: strings.dailyReports,
        subTitle: strings.dailyReportsSubTitle,
        iconPath: AppImages.dailyReports,
        onTap: () {
          // Navigate to Daily Report Page
        },
      ),
      Module(
        title: strings.reports,
        subTitle: strings.reportsSubTitle,
        iconPath: AppImages.reports,
        onTap: () {
          // Navigate to Full Reports Page
        },
      ),
      Module(
        title: strings.switchShop,
        subTitle: strings.switchShopSubTitle,
        iconPath: AppImages.switchIcon,
        onTap: () {
          Navigator.pushAndRemoveUntil(context, ShopSelectionPage.route(), (route) => false);
        },
      ),
    ];
  }
}
