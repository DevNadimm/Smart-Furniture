import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/company/presentation/pages/company_raw_material_page.dart';
import 'package:smart_furniture/features/company/presentation/pages/finished_product_page.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/employee_expense_page.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/employee_sales_page.dart';
import 'package:smart_furniture/features/shop_selector/presentation/pages/shop_selection_page.dart';
import 'package:smart_furniture/features/splash/splash_page.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class CompanyDashboardPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (_) => const CompanyDashboardPage());

  const CompanyDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            /// HEADER
            Container(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.dashboard,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Company Overview",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF64748B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  /// Logout
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      tooltip: strings.logout,
                      icon: const Icon(
                        Icons.power_settings_new_rounded,
                        color: Color(0xFFEF4444),
                      ),
                      onPressed: () {
                        AppPreferences.clearAll();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SplashPage(),
                          ), (_) => false,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            /// MODULE SECTION
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            strings.quickAccess,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF475569),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              ShopSelectionPage.route(),
                            );
                          },
                          child: const Text(
                            'Switch Shop',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF475569),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: ListView(
                        children: [

                          /// SALES (ALL BRANCHES)
                          _ModuleCard(
                            title: strings.sales,
                            subtitle: "View company-wide sales",
                            icon: HugeIcons.strokeRoundedDiscountTag02,
                            iconColor: const Color(0xFF8B5CF6),
                            backgroundColor: const Color(0xFFF5F3FF),
                            onTap: () {
                              Navigator.push(
                                context,
                                EmployeeSalesPage.route(
                                  isAdmin: true,
                                  branchId: null,
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          /// EXPENSE
                          _ModuleCard(
                            title: strings.expense,
                            subtitle: "Manage company expenses",
                            icon: HugeIcons.strokeRoundedInvoice01,
                            iconColor: const Color(0xFFEC4899),
                            backgroundColor: const Color(0xFFFDF2F8),
                            onTap: () {
                              Navigator.push(
                                context,
                                EmployeeExpensePage.route(
                                  isAdmin: true,
                                  branchId: null,
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          /// FINISHED PRODUCTS (Branch Distributed Items)
                          _ModuleCard(
                            title: 'Finished Products',
                            subtitle: "View and manage sellable products across branches",
                            icon: HugeIcons.strokeRoundedDeliveryBox01,
                            iconColor: const Color(0xFF06B6D4),
                            backgroundColor: const Color(0xFFECFEFF),
                            onTap: () {
                              Navigator.push(
                                context,
                                FinishedProductPage.route(),
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          /// RAW MATERIALS (Company Warehouse)
                          _ModuleCard(
                            title: 'Company Raw Materials',
                            subtitle: "Monitor raw materials and warehouse inventory",
                            icon: HugeIcons.strokeRoundedNanoTechnology,
                            iconColor: const Color(0xFFF59E0B),
                            backgroundColor: const Color(0xFFFFFBEB),
                            onTap: () {
                              Navigator.push(
                                context,
                                CompanyRawMaterialPage.route(),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModuleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  const _ModuleCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFE2E8F0),
              width: 1.5,
            ),
          ),
          child: Row(
            children: [
              // Icon Container
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 32,
                ),
              ),
              const SizedBox(width: 20),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                        letterSpacing: -0.3,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              // Arrow Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Color(0xFF94A3B8),
                  size: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}