import 'package:flutter/material.dart';
import 'package:smart_furniture/core/utils/widgets/shimmer_loader.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoader.loader();
  }
}

