import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_furniture/core/constants/colors.dart';

class ShimmerLoader {
  static Widget loader({int itemCount = 5}) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) => _shimmerCard(),
    );
  }

  static Widget _shimmerCard() {
    return Shimmer.fromColors(
      baseColor: AppColors.grey.withOpacity(0.3),
      highlightColor: AppColors.grey.withOpacity(0.1),
      child: Container(
        margin: const EdgeInsets.symmetric(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.cardColor.withOpacity(0.2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 40,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 16,
                    color: AppColors.white,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: AppColors.white,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 120,
                            height: 14,
                            color: AppColors.white,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: 100,
                            height: 12,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 90,
                            height: 16,
                            color: AppColors.white,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: 70,
                            height: 16,
                            color: AppColors.white,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: 100,
                            height: 16,
                            color: AppColors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
