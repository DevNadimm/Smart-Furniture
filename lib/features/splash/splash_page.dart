import 'package:flutter/material.dart';
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
      body: Center(
        child: Text("App-Name", style: Theme.of(context).textTheme.displayLarge),
      ),
    );
  }
}
