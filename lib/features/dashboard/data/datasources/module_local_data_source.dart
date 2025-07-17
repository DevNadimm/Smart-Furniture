import 'package:flutter/material.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/module.dart';

final List<Module> modules = [
  Module(
    title: 'Sales',
    icon: Icons.shopping_cart,
    primaryInfo: '৳ 24,300',
    secondaryInfo: '12 invoices today',
    onTap: () {
      // Navigate to Sales Page
    },
  ),
  Module(
    title: 'Purchase',
    icon: Icons.shopping_basket,
    primaryInfo: '৳ 12,500',
    secondaryInfo: '4 new vendors',
    onTap: () {
      // Navigate to Purchase Page
    },
  ),
  Module(
    title: 'Accounts',
    icon: Icons.account_balance_wallet,
    primaryInfo: '৳ 58,000',
    secondaryInfo: '৳ 6,000 due',
    onTap: () {
      // Navigate to Accounts Page
    },
  ),
  Module(
    title: 'HR',
    icon: Icons.group,
    primaryInfo: '14 Staff',
    secondaryInfo: '12 Present today',
    onTap: () {
      // Navigate to HR Page
    },
  ),
  Module(
    title: 'Daily Reports',
    icon: Icons.today,
    primaryInfo: '৳ 6,200',
    secondaryInfo: 'Today\'s income',
    onTap: () {
      // Navigate to Daily Report Page
    },
  ),
  Module(
    title: 'Reports',
    icon: Icons.insert_chart_outlined,
    primaryInfo: '15 Reports',
    secondaryInfo: 'This Month',
    onTap: () {
      // Navigate to Full Reports Page
    },
  ),
];
