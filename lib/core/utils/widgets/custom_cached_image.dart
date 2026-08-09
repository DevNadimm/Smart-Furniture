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

  String get _formattedUrl {
    final trimmed = imageUrl.trim();
    if (trimmed.isEmpty) return '';
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }
    if (trimmed.startsWith('/')) {
      return 'https://sff.jabedinternational.com$trimmed';
    }
    return 'https://sff.jabedinternational.com/$trimmed';
  }

  @override
  Widget build(BuildContext context) {
    final finalUrl = _formattedUrl;
    if (finalUrl.isEmpty) {
      return Container(
        width: width,
        height: height,
        color: AppColors.backgroundColor,
        child: const Center(
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedImageNotFound01,
            color: Colors.grey,
            size: 24,
          ),
        ),
      );
    }
    return CachedNetworkImage(
      imageUrl: finalUrl,
      fit: fit,
      width: width,
      height: height,
      placeholder: (context, url) => Container(
        color: AppColors.backgroundColor,
        child: const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        color: AppColors.backgroundColor,
        child: const Center(
          child: HugeIcon(
            icon: HugeIcons.strokeRoundedImageNotFound01,
            color: Colors.grey,
            size: 24,
          ),
        ),
      ),
    );
  }
}
