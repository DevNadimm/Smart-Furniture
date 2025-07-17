import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:smart_furniture/features/shop_selector/data/datasources/shop_local_data_source.dart';
import 'package:smart_furniture/features/shop_selector/domain/entities/shop.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';
import 'package:collection/collection.dart';
import 'package:smart_furniture/features/shop_selector/presentation/widgets/shop_card.dart';

class ShopSelectionPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const ShopSelectionPage());

  const ShopSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppLocalizations strings = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, strings),
              const SizedBox(height: 32),
              _buildShopGrid(),
              const Spacer(),
              _buildBtn(strings),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AppLocalizations strings) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          strings.selectShopTitle,
          style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          strings.selectShopSubtitle,
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
      itemBuilder: (context, index) => ShopCard(shop: shops[index]),
    );
  }

  Widget _buildBtn(AppLocalizations strings) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<ShopSelectionCubit, String>(
        builder: (context, shopId) {
          Shop? shop = shops.firstWhereOrNull((shop) => shop.id == shopId);

          return ElevatedButton.icon(
            icon: const Icon(HugeIcons.strokeRoundedArrowRight02),
            iconAlignment: IconAlignment.end,
            label: Text(strings.nextScreenBtn),
            onPressed: shop != null ? () => Navigator.pushReplacement(context, DashboardPage.route(shop: shop)) : null,
          );
        },
      ),
    );
  }
}
