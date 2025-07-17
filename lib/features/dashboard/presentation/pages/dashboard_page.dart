import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/features/shop_selection/domain/entities/shop.dart';

class DashboardPage extends StatelessWidget {
  final Shop shop;
  static route({required Shop shop}) => MaterialPageRoute(builder: (_) => DashboardPage(shop: shop));

  const DashboardPage({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 32),
              _buildGridView(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader (BuildContext context, ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(shop.name, style: Theme.of(context).textTheme.displaySmall,),
        const SizedBox(height: 8),
        Text(shop.description, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Row(
          children: [
            const Icon(Icons.location_on_rounded, size: 16, color: AppColors.lightFontColor),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                shop.location,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.lightFontColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      itemCount: dashboardModules.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        return _buildCard(context, dashboardModules[index]);
      },
    );
  }

  Widget _buildCard(BuildContext context, Module module) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: AppColors.white,
            blurRadius: 20,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: module.onTap,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(module.icon, color: AppColors.primaryColor),
                ),
                const SizedBox(height: 12),
                Text(
                  module.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  module.primaryInfo,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  module.secondaryInfo,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                const Text(
                  'View Details →',
                  style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Module {
  final String title;
  final IconData icon;
  final String primaryInfo;
  final String secondaryInfo;
  final VoidCallback onTap;

  Module({
    required this.title,
    required this.icon,
    required this.primaryInfo,
    required this.secondaryInfo,
    required this.onTap,
  });
}

final List<Module> dashboardModules = [
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
