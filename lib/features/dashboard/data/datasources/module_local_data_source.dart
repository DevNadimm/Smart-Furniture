import 'package:flutter/cupertino.dart';
import 'package:smart_furniture/core/constants/image_paths.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/module.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ModuleLocalDataSource {
  static List<Module> getModules(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return [
      Module(
        title: strings.purchase,
        iconPath: AppImages.purchase,
        primaryInfo: '৳ 12,500',
        secondaryInfo: '4 new vendors',
        onTap: () {
          // Navigate to Purchase Page
        },
      ),
      Module(
        title: strings.sales,
        iconPath: AppImages.sales,
        primaryInfo: '৳ 24,300',
        secondaryInfo: '12 invoices today',
        onTap: () {
          // Navigate to Sales Page
        },
      ),
      Module(
        title: strings.accounts,
        iconPath: AppImages.accounts,
        primaryInfo: '৳ 58,000',
        secondaryInfo: '৳ 6,000 due',
        onTap: () {
          // Navigate to Accounts Page
        },
      ),
      Module(
        title: strings.hr,
        iconPath: AppImages.hr,
        primaryInfo: '14 Staff',
        secondaryInfo: '12 Present today',
        onTap: () {
          // Navigate to HR Page
        },
      ),
      Module(
        title: strings.dailyReports,
        iconPath: AppImages.dailyReports,
        primaryInfo: '৳ 6,200',
        secondaryInfo: 'Today\'s income',
        onTap: () {
          // Navigate to Daily Report Page
        },
      ),
      Module(
        title: strings.reports,
        iconPath: AppImages.reports,
        primaryInfo: '15 Reports',
        secondaryInfo: 'This Month',
        onTap: () {
          // Navigate to Full Reports Page
        },
      ),
    ];
  }
}