import 'package:smart_furniture/features/shop_selector/domain/entities/shop_type.dart';

class BaseUrl {
  BaseUrl._();

  static final Map<String, String> _baseUrls = {
    ShopType.shop1.name: "https://sfapi.qualityf.xyz/api",
    ShopType.shop2.name: "https://sfapi.qualityf.xyz/api",
    ShopType.shop3.name: "https://sfapi.qualityf.xyz/api",
    ShopType.shop4.name: "https://sfapi.qualityf.xyz/api",
  };

  static String getBaseUrl(String shopId) {
    if (!_baseUrls.containsKey(shopId)) {
      throw ArgumentError("Invalid shopId: $shopId");
    }
    return _baseUrls[shopId]!;
  }
}
