import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/features/shop_selector/data/models/branch_model.dart';
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

class ShopModel {
  final int? id;
  final String name;
  final String? email;
  final String? contactNumber;
  final String? contactPersonName;
  final String? contactPersonNumber;
  final String? area;
  final String? address;
  final Color color;
  final IconData icon;
  final bool isActive;

  ShopModel({
    this.id,
    required this.name,
    this.email,
    this.contactNumber,
    this.contactPersonName,
    this.contactPersonNumber,
    this.area,
    this.address,
    this.color = AppColors.primaryColor,
    this.icon = Icons.store,
    this.isActive = true,
  });

  /// Factory constructor to create Shop from BranchData (API response)
  factory ShopModel.fromBranchData(BranchData branch) {
    return ShopModel(
      id: branch.id,
      name: branch.name ?? 'Unknown Branch',
      email: branch.email,
      contactNumber: branch.contactNumber,
      contactPersonName: branch.contactPersonName,
      contactPersonNumber: branch.contactPersonNumber,
      area: branch.area,
      address: branch.address,
      color: AppColors.primaryColor,
      icon: Icons.store,
      isActive: true,
    );
  }

  /// Convert Shop to BranchData
  BranchData toBranchData() {
    return BranchData(
      id: id,
      name: name,
      email: email,
      contactNumber: contactNumber,
      contactPersonName: contactPersonName,
      contactPersonNumber: contactPersonNumber,
      area: area,
      address: address,
    );
  }

  /// Copy with method for immutability
  ShopModel copyWith({
    int? id,
    String? name,
    String? email,
    String? contactNumber,
    String? contactPersonName,
    String? contactPersonNumber,
    String? area,
    String? address,
    Color? color,
    IconData? icon,
    bool? isActive,
  }) {
    return ShopModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      contactNumber: contactNumber ?? this.contactNumber,
      contactPersonName: contactPersonName ?? this.contactPersonName,
      contactPersonNumber: contactPersonNumber ?? this.contactPersonNumber,
      area: area ?? this.area,
      address: address ?? this.address,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      isActive: isActive ?? this.isActive,
    );
  }
}