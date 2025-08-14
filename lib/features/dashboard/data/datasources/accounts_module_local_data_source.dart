import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/core/constants/image_paths.dart';
import 'package:smart_furniture/features/administration/presentation/pages/product_list_page.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/sales_module.dart';

class AccountsModuleLocalDataSource {
  static List<SubModule> getAccountsModules(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return [
      SubModule(
        title: strings.bankTransactionTitle,
        subTitle: strings.bankTransactionSubtitle,
        iconPath: AppImages.bankTransaction,
        onTap: () {
          Navigator.push(context, ProductListPage.route());
        },
      ),
      SubModule(
        title: strings.cashTransactionTitle,
        subTitle: strings.cashTransactionSubtitle,
        iconPath: AppImages.cashTransaction,
        onTap: () {
          Navigator.push(context, ProductListPage.route());
        },
      ),
      SubModule(
        title: strings.cashStatementTitle,
        subTitle: strings.cashStatementSubtitle,
        iconPath: AppImages.reports,
        onTap: () {
          Navigator.push(context, ProductListPage.route());
        },
      ),
      SubModule(
        title: strings.pendingChequeListTitle,
        subTitle: strings.pendingChequeListSubtitle,
        iconPath: AppImages.cheque,
        onTap: () {
          Navigator.push(context, ProductListPage.route());
        },
      ),
      SubModule(
        title: strings.reminderChequeListTitle,
        subTitle: strings.reminderChequeListSubtitle,
        iconPath: AppImages.cheque,
        onTap: () {
          Navigator.push(context, ProductListPage.route());
        },
      ),
      SubModule(
        title: strings.balanceSheetTitle,
        subTitle: strings.balanceSheetSubtitle,
        iconPath: AppImages.reports,
        onTap: () {
          Navigator.push(context, ProductListPage.route());
        },
      ),
    ];
  }
}
