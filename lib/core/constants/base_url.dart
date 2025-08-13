class BaseUrl {
  BaseUrl._();

  static final Map<String, String> _baseUrls = {
    "shop_1": "https://sfapi.qualityf.xyz/api",
    "shop_2": "https://sfapi.qualityf.xyz/api",
    "shop_3": "https://sfapi.qualityf.xyz/api",
    "shop_4": "https://sfapi.qualityf.xyz/api",
  };

  static String getBaseUrl(String shopId) {
    if (!_baseUrls.containsKey(shopId)) {
      throw ArgumentError("Invalid shopId: $shopId");
    }
    return _baseUrls[shopId]!;
  }
}
