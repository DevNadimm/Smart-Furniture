import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/core/constants/image_paths.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/sub_module.dart';

class ReportsModuleLocalDataSource {
  static List<SubModule> getReportsModules(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return [
      SubModule(
        title: strings.supplierPaymentReportTitle,
        subTitle: strings.supplierPaymentReportSubtitle,
        iconPath: AppImages.reports,
        onTap: () {},
      ),
      SubModule(
        title: strings.customerPaymentReportTitle,
        subTitle: strings.customerPaymentReportSubtitle,
        iconPath: AppImages.reports,
        onTap: () {},
      ),
      SubModule(
        title: strings.profitLossReportTitle,
        subTitle: strings.profitLossReportSubtitle,
        iconPath: AppImages.profitLoss,
        onTap: () {},
      ),
    ];
  }
}
