import 'package:flutter/material.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/image_paths.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/language_selector/presentation/pages/language_selection_page.dart';
import 'package:smart_furniture/features/shop_selector/presentation/pages/shop_selection_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 3));
    final isFirstTimeUser = await AppPreferences.isFirstTimeUser();

    isFirstTimeUser
        ? Navigator.pushReplacement(context, LanguageSelectionPage.route())
        : Navigator.pushReplacement(context, ShopSelectionPage.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppImages.smartFurnitureSplash, scale: 4, color: AppColors.white),
              const SizedBox(height: 10),
              Text(
                "Smart Furniture",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
