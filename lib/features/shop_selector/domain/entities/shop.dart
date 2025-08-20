import 'package:flutter/material.dart';
import 'package:smart_furniture/core/utils/enums/shop_type.dart';

class Shop {
  final ShopType shopType;
  final String name;
  final Color color;
  final IconData icon;
  final bool isActive;

  Shop({
    required this.shopType,
    required this.name,
    required this.color,
    required this.icon,
    required this.isActive,
  });
}
