import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';

class ShopSelectionPage extends StatelessWidget {
  const ShopSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 32),
            _buildShopGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 80),
        Text(
          'Select Shop',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32),
        ),
        const SizedBox(height: 8),
        Text(
          'Choose a shop to manage and view analytics',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }

  Widget _buildShopGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: shops.length,
      itemBuilder: (context, index) => _buildShopCard(context, shops[index]),
    );
  }

  Widget _buildShopCard(BuildContext context, Map<String, dynamic> shop) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: AppColors.white,
            blurRadius: 20,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _selectShop(context, shop),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: shop['color'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        shop['icon'],
                        color: shop['color'],
                        size: 24,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        shop['status'],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.green),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  shop['name'],
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Text(
                  shop['description'],
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded, size: 16, color: AppColors.lightFontColor),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        shop['location'],
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectShop(BuildContext context, Map<String, dynamic> shop) {
    AppNotifier.showSnackBar(context, '${shop['name']} selected');
  }
}

const List<Map<String, dynamic>> shops = [
  {
    'name': 'Main Street Furniture',
    'id': 'shop_1',
    'description': 'Primary retail location',
    'color': Colors.blue,
    'icon': Icons.store,
    'location': '123 Main Street, Dhaka',
    'status': 'Active'
  },
  {
    'name': 'Downtown Furnishings',
    'id': 'shop_2',
    'description': 'City center location',
    'color': Colors.red,
    'icon': Icons.store,
    'location': '45 Central Ave, Chittagong',
    'status': 'Active'
  },
  {
    'name': 'Mall Furniture Outlet',
    'id': 'shop_3',
    'description': 'Shopping mall store',
    'color': Colors.orange,
    'icon': Icons.store,
    'location': '67 Plaza Rd, Sylhet',
    'status': 'Active'
  },
  {
    'name': 'Online Furniture Hub',
    'id': 'shop_4',
    'description': 'E-commerce platform',
    'color': Colors.purple,
    'icon': Icons.store,
    'location': 'Nationwide',
    'status': 'Active'
  },
];
