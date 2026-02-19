import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';

class CustomCachedImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;
  final String loadingAsset;
  final String errorAsset;

  const CustomCachedImage({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    this.loadingAsset = 'assets/images/loading.png',
    this.errorAsset = 'assets/images/error.png',
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) => Container(color: AppColors.backgroundColor, child: const Center(child: CircularProgressIndicator())),
      errorWidget: (context, url, error) => Container(color: AppColors.backgroundColor, child: const Center(child: HugeIcon(icon: HugeIcons.strokeRoundedImageNotFound01, color: Colors.red, size: 30))),
    );
  }
}
