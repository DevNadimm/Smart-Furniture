import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/custom_text_field.dart';
import 'package:smart_furniture/features/auth/presentation/blocs/employee_login/login_bloc.dart';
import 'package:smart_furniture/features/employee_dashboard/presentation/pages/employee_dashboard_page.dart';
import 'package:smart_furniture/l10n/app_localizations.dart';

class EmployeeLoginPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const EmployeeLoginPage());

  const EmployeeLoginPage({super.key});

  @override
  State<EmployeeLoginPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<EmployeeLoginPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        }
        if (state is LoginSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            EmployeeDashboardPage.route(),
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(strings),
            if (state is LoginLoading)
              Container(
                height: double.infinity,
                width: double.infinity,
                color: AppColors.black.withValues(alpha: 0.6),
                child: const Center(child: CircularProgressIndicator(color: AppColors.white,)),
              ),
          ],
        );
      },
    );
  }

  Widget content(AppLocalizations strings) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.adminLoginTitle),
        // leading: const AppBarBackBtn(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Form(
            key: _globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  strings.employeeLoginWelcome,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryFontColor,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  label: strings.adminLoginEmail,
                  controller: _emailController,
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                  hintText: strings.adminLoginEmailHint,
                  validationLabel: strings.adminLoginEmail,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: strings.adminLoginPassword,
                  controller: _passwordController,
                  isRequired: true,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: strings.adminLoginPasswordHint,
                  validationLabel: strings.adminLoginPassword,
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(context, ForgotPasswordPage.route());
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        strings.adminLoginForgotPassword,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => onTapLogin(),
                    child: Text(strings.adminLoginButton),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapLogin() {
    if (_globalKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
            LoginUserEvent(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
