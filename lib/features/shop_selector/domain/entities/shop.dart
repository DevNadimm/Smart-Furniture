import 'package:flutter/material.dart';

class Shop {
  final String id;
  final String name;
  final String description;
  final String location;
  final Color color;
  final IconData icon;
  final bool isActive;

  Shop({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.color,
    required this.icon,
    required this.isActive,
  });
}
