import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/core/constants/image_paths.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/sales_module.dart';
import 'package:smart_furniture/features/hr_and_payroll/presentation/pages/salary_payment_page.dart';

class HrModuleLocalDataSource {
  static List<SubModule> getHrModules(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return [
      SubModule(
        title: strings.salaryPaymentTitle,
        subTitle: strings.salaryPaymentSubtitle,
        iconPath: AppImages.salary,
        onTap: () {
          Navigator.push(context, SalaryPaymentPage.route());
        },
      ),
      SubModule(
        title: strings.employeeListTitle,
        subTitle: strings.employeeListSubtitle,
        iconPath: AppImages.employee,
        onTap: () {},
      ),
    ];
  }
}
