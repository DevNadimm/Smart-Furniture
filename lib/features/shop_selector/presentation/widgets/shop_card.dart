import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/image_paths.dart';
import 'package:smart_furniture/core/utils/enums/shop_type.dart';
import 'package:smart_furniture/features/shop_selector/domain/entities/shop.dart';
import 'package:smart_furniture/features/shop_selector/presentation/cubit/shop_selection_cubit.dart';

class ShopCard extends StatelessWidget {
  final Shop shop;

  const ShopCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopSelectionCubit, ShopType?>(
      builder: (context, shopType) {
        final bool isSelected = shop.shopType == shopType;

        return Container(
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : AppColors.cardColor,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              width: 1.4,
              color: isSelected ? AppColors.primaryColor : AppColors.borderColor,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.cardColor,
                blurRadius: 20,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () => context.read<ShopSelectionCubit>().selectShop(shop.shopType),
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: shop.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.asset(AppImages.store, color: shop.color, scale: 6),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: shop.isActive ? AppColors.success.withOpacity(0.1) : AppColors.error.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            shop.isActive ? 'Active' : 'Inactive',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: shop.isActive ? AppColors.success : AppColors.error,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Spacer(),
                    Text(
                      shop.name,
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // const Spacer(),
                    // Text(
                    //   shop.description,
                    //   style: Theme.of(context).textTheme.titleMedium,
                    //   maxLines: 1,
                    //   overflow: TextOverflow.ellipsis,
                    // ),
                    // const SizedBox(height: 6),
                    // Row(
                    //   children: [
                    //     const Icon(Icons.location_on_rounded, size: 16, color: AppColors.lightFontColor),
                    //     const SizedBox(width: 4),
                    //     Expanded(
                    //       child: Text(
                    //         shop.location,
                    //         style: Theme.of(context).textTheme.bodySmall,
                    //         maxLines: 1,
                    //         overflow: TextOverflow.ellipsis,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
