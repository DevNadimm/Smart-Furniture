import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:smart_furniture/core/constants/image_paths.dart';
import 'package:smart_furniture/features/auth/presentation/pages/admin_login_page.dart';
import 'package:smart_furniture/features/shop_selector/presentation/pages/shop_selection_page.dart';
import 'package:smart_furniture/features/user_role_selector/presentation/cubit/user_role_cubit.dart';
import 'package:smart_furniture/features/user_role_selector/presentation/widgets/user_role_card.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class UserRoleSelectionPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const UserRoleSelectionPage());

  const UserRoleSelectionPage({super.key});

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
                      strings.chooseUserRoleHeader,
                      style: Theme.of(context).textTheme.displayMedium?.copyWith(fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      strings.chooseUserRoleSubtitle,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              /// Language Card
              BlocBuilder<UserRoleCubit, String?>(
                builder: (context, role) {
                  return Column(
                    children: [
                      UserRoleCard(
                        roleName: strings.adminRole,
                        roleCode: 'admin',
                        selectedCode: role ?? '',
                        onTap: () => context.read<UserRoleCubit>().selectUserRole('admin'),
                        imageName: AppImages.admin,
                      ),
                      const SizedBox(height: 16),
                      UserRoleCard(
                        roleName: strings.employeeRole,
                        roleCode: 'employee',
                        selectedCode: role ?? '',
                        onTap: () => context.read<UserRoleCubit>().selectUserRole('employee'),
                        imageName: AppImages.human,
                      ),
                    ],
                  );
                },
              ),
              const Spacer(),

              /// Continue Button
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<UserRoleCubit, String?>(
                  builder: (context, role) {
                    return ElevatedButton.icon(
                      onPressed: role == null
                          ? null
                          : () => role == 'admin'
                              ? Navigator.pushReplacement(context, AdminLoginPage.route())
                              : Navigator.pushReplacement(context, ShopSelectionPage.route()),
                      icon: const Icon(HugeIcons.strokeRoundedArrowRight02),
                      iconAlignment: IconAlignment.end,
                      label: Text(strings.nextScreenBtn),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
