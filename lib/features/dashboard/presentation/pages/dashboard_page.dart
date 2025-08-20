import 'package:flutter/material.dart';
import 'package:smart_furniture/features/dashboard/data/datasources/module_local_data_source.dart';
import 'package:smart_furniture/features/dashboard/presentation/widgets/module_card.dart';
import 'package:smart_furniture/features/language_selector/presentation/pages/language_selection_page.dart';
import 'package:smart_furniture/features/shop_selector/domain/entities/shop.dart';

class DashboardPage extends StatelessWidget {
  final Shop shop;
  static route({required Shop shop}) => MaterialPageRoute(builder: (_) => DashboardPage(shop: shop));

  const DashboardPage({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    // final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(shop.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGridView(context),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(context, LanguageSelectionPage.route(), (route) => false);
                },
                child: const Text("Change Localization"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildHeader (BuildContext context, ) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(shop.name, style: Theme.of(context).textTheme.displaySmall,),
  //       const SizedBox(height: 8),
  //       Text(shop.description, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600)),
  //       const SizedBox(height: 6),
  //       Row(
  //         children: [
  //           const Icon(Icons.location_on_rounded, size: 16, color: AppColors.lightFontColor),
  //           const SizedBox(width: 4),
  //           Expanded(
  //             child: Text(
  //               shop.location,
  //               style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.lightFontColor),
  //               maxLines: 1,
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

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
        childAspectRatio: 1.06,
      ),
      itemCount: modules.length,
      itemBuilder: (context, index) => ModuleCard(module: modules[index]),
    );
  }
}
