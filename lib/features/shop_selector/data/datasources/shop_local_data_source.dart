import 'package:flutter/material.dart';
import 'package:smart_furniture/core/utils/enums/shop_type.dart';
import 'package:smart_furniture/features/shop_selector/domain/entities/shop.dart';

List<Shop> shops = [
  Shop(
    shopType: ShopType.shop1,
    name: 'Main Street Furniture',
    description: 'Primary retail location',
    location: '123 Main Street, Dhaka',
    color: Colors.blue,
    icon: Icons.shopify_rounded,
    isActive: true,
  ),
  Shop(
    shopType: ShopType.shop2,
    name: 'Downtown Furnishings',
    description: 'City center location',
    location: '45 Central Ave, Chittagong',
    color: Colors.red,
    icon: Icons.shopify_rounded,
    isActive: true,
  ),
  Shop(
    shopType: ShopType.shop3,
    name: 'Mall Furniture Outlet',
    description: 'Shopping mall store',
    location: '67 Plaza Rd, Sylhet',
    color: Colors.orange,
    icon: Icons.shopify_rounded,
    isActive: true,
  ),
  Shop(
    shopType: ShopType.shop4,
    name: 'Online Furniture Hub',
    description: 'E-commerce platform',
    location: 'Nationwide',
    color: Colors.purple,
    icon: Icons.shopify_rounded,
    isActive: false,
  ),
];
