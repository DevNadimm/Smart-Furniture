import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/services/app_preferences.dart';
import 'package:smart_furniture/features/shop_selector/presentation/pages/shop_selection_page.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class AdminLoginPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (_) => const AdminLoginPage());

  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final _pinController = TextEditingController();
  String? _errorText;

  void _login() {
    final strings = AppLocalizations.of(context)!;

    if (_pinController.text == '123456') {
      AppPreferences.setLoggedIn(true);
      Navigator.pushReplacement(
        context,
        ShopSelectionPage.route(),
      );
    } else {
      setState(() {
        _errorText = strings.adminLoginError;
      });
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Icon(
                HugeIcons.strokeRoundedSquareLockPassword,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 24),
              Text(
                strings.adminLoginHeader,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Text(
                strings.adminLoginSubtitle,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
                textAlign: TextAlign.center,
              ),
        
              const SizedBox(height: 32),
        
              TextField(
                controller: _pinController,
                keyboardType: TextInputType.number,
                obscureText: true,
                maxLength: 6,
                decoration: InputDecoration(
                  labelText: strings.adminPinLabel,
                  errorText: _errorText,
                  border: const OutlineInputBorder(),
                ),
              ),
        
              const SizedBox(height: 24),
        
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _login,
                  child: Text(strings.adminLoginButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
