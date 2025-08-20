import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/core/utils/enums/shop_type.dart';
import 'package:smart_furniture/features/shop_selector/domain/entities/shop.dart';

class ShopLocalDataSource {
  ShopLocalDataSource._();

  static List<Shop> getShops(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return [
      Shop(
        shopType: ShopType.shop1,
        name: strings.shopSmartFurniture,
        color: Colors.blue,
        icon: Icons.shopify_rounded,
        isActive: true,
      ),
      Shop(
        shopType: ShopType.shop2,
        name: strings.shopNoorjahanFurniture,
        color: Colors.red,
        icon: Icons.shopify_rounded,
        isActive: true,
      ),
      Shop(
        shopType: ShopType.shop3,
        name: strings.shopNaimFurniture,
        color: Colors.orange,
        icon: Icons.shopify_rounded,
        isActive: true,
      ),
      Shop(
        shopType: ShopType.shop4,
        name: strings.shopNoorjahanSteel,
        color: Colors.purple,
        icon: Icons.shopify_rounded,
        isActive: true,
      ),
    ];
  }
}
