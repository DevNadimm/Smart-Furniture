import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/constants/image_paths.dart';
import 'package:smart_furniture/features/language_selector/presentation/cubit/language_cubit.dart';
import 'package:smart_furniture/features/shop_selection/presentation/pages/shop_selection_page.dart';

class LanguageSelectionPage extends StatelessWidget {
  const LanguageSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    'Choose your language',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Select your preferred language to personalize your app experience.',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 64),
            BlocBuilder<LanguageCubit, String>(
              builder: (context, selectedLang) {
                return Column(
                  children: [
                    _buildLanguageCard(
                      context,
                      lnName: 'English',
                      lnImageName: AppImages.flagEn,
                      selectedLang: selectedLang,
                      onTap: () => context.read<LanguageCubit>().selectLanguage('english'),
                    ),
                    const SizedBox(height: 16),
                    _buildLanguageCard(
                      context,
                      lnName: 'Bengali',
                      lnImageName: AppImages.flagBn,
                      selectedLang: selectedLang,
                      onTap: () => context.read<LanguageCubit>().selectLanguage('bengali'),
                    ),
                  ],
                );
              },
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => Navigator.pushReplacement(context, ShopSelectionPage.route()),
                icon: const Icon(HugeIcons.strokeRoundedArrowRight02),
                label: const Text("Continue"),
                iconAlignment: IconAlignment.end,
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildLanguageCard(
    BuildContext context, {
    required String lnName,
    required String lnImageName,
    required String selectedLang,
    required VoidCallback onTap,
  }) {
    bool isSelected = selectedLang == lnName.toLowerCase();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : Colors.transparent,
          border: Border.all(
            width: 1.4,
            color: isSelected ? AppColors.primaryColor : AppColors.cardColorBold,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: CircleAvatar(
                radius: 10,
                backgroundImage: AssetImage(lnImageName),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              lnName,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            Icon(
              isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: isSelected ? AppColors.primaryColor : AppColors.cardColorBold,
            )
          ],
        ),
      ),
    );
  }
}
