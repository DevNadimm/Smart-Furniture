import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/core/constants/image_paths.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/sales_module.dart';
import 'package:smart_furniture/features/hr_and_payroll/presentation/pages/salary_payment_page.dart';

class AdministrationModuleLocalDataSource {
  static List<SubModule> getAdministrationModules(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return [
      SubModule(
        title: strings.productListTitle,
        subTitle: strings.productListSubtitle,
        iconPath: AppImages.product,
        onTap: () {
          Navigator.push(context, SalaryPaymentPage.route());
        },
      ),
      SubModule(
        title: strings.damageListTitle,
        subTitle: strings.damageListSubtitle,
        iconPath: AppImages.damage,
        onTap: () {
          Navigator.push(context, SalaryPaymentPage.route());
        },
      ),
      SubModule(
        title: strings.customerListTitle,
        subTitle: strings.customerListSubtitle,
        iconPath: AppImages.customers,
        onTap: () {
          Navigator.push(context, SalaryPaymentPage.route());
        },
      ),
      SubModule(
        title: strings.supplierListTitle,
        subTitle: strings.supplierListSubtitle,
        iconPath: AppImages.suppliers,
        onTap: () {
          Navigator.push(context, SalaryPaymentPage.route());
        },
      ),
      SubModule(
        title: strings.productLedgerTitle,
        subTitle: strings.productLedgerSubtitle,
        iconPath: AppImages.productLedger,
        onTap: () {
          Navigator.push(context, SalaryPaymentPage.route());
        },
      ),
    ];
  }
}
