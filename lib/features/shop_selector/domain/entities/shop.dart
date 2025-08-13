import 'package:flutter/material.dart';
import 'package:smart_furniture/features/shop_selector/domain/entities/shop_type.dart';

class Shop {
  final ShopType shopType;
  final String name;
  final String description;
  final String location;
  final Color color;
  final IconData icon;
  final bool isActive;

  Shop({
    required this.shopType,
    required this.name,
    required this.description,
    required this.location,
    required this.color,
    required this.icon,
    required this.isActive,
  });
}
