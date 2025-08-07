import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/dashboard/data/datasources/module_local_data_source.dart';
import 'package:smart_furniture/features/dashboard/presentation/widgets/module_card.dart';
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
              ),
              // const Spacer(),
              // ElevatedButton(onPressed: () => Navigator.push(context, LanguageSelectionPage.route()), child: const Text("Change Localization"))
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
    final modules = ModuleLocalDataSource.getModules(context);

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
      itemBuilder: (context, index) => ModuleCard(module: modules[index]),
    );
  }
}
