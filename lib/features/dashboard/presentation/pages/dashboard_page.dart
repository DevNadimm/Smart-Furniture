import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/dashboard/data/datasources/module_local_data_source.dart';
import 'package:smart_furniture/features/dashboard/domain/entities/module.dart';
import 'package:smart_furniture/features/shop_selector/domain/entities/shop.dart';
import 'package:smart_furniture/features/shop_selector/presentation/pages/shop_selection_page.dart';

class DashboardPage extends StatelessWidget {
  final Shop shop;
  static route({required Shop shop}) => MaterialPageRoute(builder: (_) => DashboardPage(shop: shop));

  const DashboardPage({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

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
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pushAndRemoveUntil(context, ShopSelectionPage.route(), (route) => false,),
                  icon: const Icon(HugeIcons.strokeRoundedExchange01),
                  label: Text(strings.changeShopBtn),
                  iconAlignment: IconAlignment.end,
                ),
              )
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
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.05,
      ),
      itemCount: modules.length,
      itemBuilder: (context, index) => _buildCard(context, modules[index]),
    );
  }

  Widget _buildCard(BuildContext context, Module module) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(width: 1.4, color: AppColors.borderColor),
        boxShadow: const [
          BoxShadow(
            color: AppColors.cardColor,
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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Text(
                  module.primaryInfo,
                  style: Theme.of(context).textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  module.secondaryInfo,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
