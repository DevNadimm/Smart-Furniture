import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/image_paths.dart';
import 'package:smart_furniture/features/language_selector/presentation/cubit/language_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smart_furniture/features/language_selector/presentation/widgets/language_card.dart';
import 'package:smart_furniture/features/shop_selector/presentation/pages/shop_selection_page.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 30),

              /// Header Part
              SizedBox(
                height: 160,
                child: Column(
                  children: [
                    Text(
                      strings.appBarTxt,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      strings.languageScreenSubtitle,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              /// Language Card
              BlocBuilder<LanguageCubit, Locale>(
                builder: (context, locale) {
                  return Column(
                    children: [
                      LanguageCard(
                        lnName: 'English',
                        lnCode: 'en',
                        lnImageName: AppImages.flagEn,
                        selectedCode: locale.languageCode,
                        onTap: () => context.read<LanguageCubit>().selectLanguage('en'),
                      ),
                      const SizedBox(height: 16),
                      LanguageCard(
                        lnName: 'বাংলা',
                        lnCode: 'bn',
                        lnImageName: AppImages.flagBn,
                        selectedCode: locale.languageCode,
                        onTap: () => context.read<LanguageCubit>().selectLanguage('bn'),
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),

              /// Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.pushReplacement(context, ShopSelectionPage.route()),
                  icon: const Icon(HugeIcons.strokeRoundedArrowRight02),
                  iconAlignment: IconAlignment.end,
                  label: Text(strings.nextScreenBtn),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
