import 'package:smart_furniture/core/constants/image_paths.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/module.dart';

final List<Module> modules = [
  Module(
    title: 'Sales',
    iconPath: AppImages.sales,
    primaryInfo: '৳ 24,300',
    secondaryInfo: '12 invoices today',
    onTap: () {
      // Navigate to Sales Page
    },
  ),
  Module(
    title: 'Purchase',
    iconPath: AppImages.purchase,
    primaryInfo: '৳ 12,500',
    secondaryInfo: '4 new vendors',
    onTap: () {
      // Navigate to Purchase Page
    },
  ),
  Module(
    title: 'Accounts',
    iconPath: AppImages.accounts,
    primaryInfo: '৳ 58,000',
    secondaryInfo: '৳ 6,000 due',
    onTap: () {
      // Navigate to Accounts Page
    },
  ),
  Module(
    title: 'HR',
    iconPath: AppImages.hr,
    primaryInfo: '14 Staff',
    secondaryInfo: '12 Present today',
    onTap: () {
      // Navigate to HR Page
    },
  ),
  Module(
    title: 'Daily Reports',
    iconPath: AppImages.dailyReports,
    primaryInfo: '৳ 6,200',
    secondaryInfo: 'Today\'s income',
    onTap: () {
      // Navigate to Daily Report Page
    },
  ),
  Module(
    title: 'Reports',
    iconPath: AppImages.reports,
    primaryInfo: '15 Reports',
    secondaryInfo: 'This Month',
    onTap: () {
      // Navigate to Full Reports Page
    },
  ),
];
