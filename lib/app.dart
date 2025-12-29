import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smart_furniture/core/utils/themes/theme.dart';
import 'package:smart_furniture/features/language_selector/presentation/cubit/language_cubit.dart';
import 'package:smart_furniture/features/splash/splash_page.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp(
          locale: locale,
          supportedLocales: const [
            Locale('en'),
            Locale('bn'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: 'Smart Furniture',
          theme: theme,
          home: const SplashPage(),
        );
      },
    );
  }
}
