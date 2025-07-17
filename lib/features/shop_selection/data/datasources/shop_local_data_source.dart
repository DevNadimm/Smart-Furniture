import 'package:flutter/material.dart';
import 'package:smart_furniture/features/shop_selection/domain/entities/shop.dart';

List<Shop> shops = [
  Shop(
    id: 'shop_1',
    name: 'Main Street Furniture',
    description: 'Primary retail location',
    location: '123 Main Street, Dhaka',
    color: Colors.blue,
    icon: Icons.store,
    status: 'Active',
  ),
  Shop(
    id: 'shop_2',
    name: 'Downtown Furnishings',
    description: 'City center location',
    location: '45 Central Ave, Chittagong',
    color: Colors.red,
    icon: Icons.store,
    status: 'Active',
  ),
  Shop(
    id: 'shop_3',
    name: 'Mall Furniture Outlet',
    description: 'Shopping mall store',
    location: '67 Plaza Rd, Sylhet',
    color: Colors.orange,
    icon: Icons.store,
    status: 'Active',
  ),
  Shop(
    id: 'shop_4',
    name: 'Online Furniture Hub',
    description: 'E-commerce platform',
    location: 'Nationwide',
    color: Colors.purple,
    icon: Icons.store,
    status: 'Active',
  ),
];
