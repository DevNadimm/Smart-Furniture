import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smart_furniture/core/constants/colors.dart';
import 'package:smart_furniture/core/utils/enums/message_type.dart';
import 'package:smart_furniture/core/utils/widgets/app_notifier.dart';
import 'package:smart_furniture/core/utils/widgets/custom_text_field.dart';
import 'package:smart_furniture/features/auth/presentation/blocs/employee_login/login_bloc.dart';
import 'package:smart_furniture/features/shop_selector/presentation/pages/shop_selection_page.dart';

class AdminLoginPage extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (_) => const AdminLoginPage());

  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<AdminLoginPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          AppNotifier.showToast(state.message, type: MessageType.error);
        }
        if (state is LoginSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            ShopSelectionPage.route(), (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            content(),
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

  Widget content() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login to Your Account'),
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
                  "Welcome back! Manage branches, sales, and operations seamlessly from your admin dashboard.",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryFontColor,
                  ),
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  isRequired: true,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter email',
                  validationLabel: 'Email',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Password',
                  controller: _passwordController,
                  isRequired: true,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: 'Enter password',
                  validationLabel: 'Confirm Password',
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(context, ForgotPasswordPage.route());
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(
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
                    child: const Text('Login'),
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











// import 'package:flutter/material.dart';
// import 'package:hugeicons/hugeicons.dart';
// import 'package:smart_furniture/core/services/app_preferences.dart';
// import 'package:smart_furniture/features/shop_selector/presentation/pages/shop_selection_page.dart';
// import 'package:smart_furniture/l10n/app_localizations.dart';
//
// class AdminLoginPage extends StatefulWidget {
//   static route() => MaterialPageRoute(builder: (_) => const AdminLoginPage());
//
//   const AdminLoginPage({super.key});
//
//   @override
//   State<AdminLoginPage> createState() => _AdminLoginPageState();
// }
//
// class _AdminLoginPageState extends State<AdminLoginPage> {
//   final _pinController = TextEditingController();
//   String? _errorText;
//
//   void _login() {
//     final strings = AppLocalizations.of(context)!;
//
//     if (_pinController.text == '123456') {
//       AppPreferences.setLoggedIn(true);
//       Navigator.pushReplacement(
//         context,
//         ShopSelectionPage.route(),
//       );
//     } else {
//       setState(() {
//         _errorText = strings.adminLoginError;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _pinController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final strings = AppLocalizations.of(context)!;
//
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               const SizedBox(height: 40),
//               Icon(
//                 HugeIcons.strokeRoundedSquareLockPassword,
//                 size: 80,
//                 color: Theme.of(context).primaryColor,
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 strings.adminLoginHeader,
//                 style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 strings.adminLoginSubtitle,
//                 style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
//                 textAlign: TextAlign.center,
//               ),
//
//               const SizedBox(height: 32),
//
//               TextField(
//                 controller: _pinController,
//                 keyboardType: TextInputType.number,
//                 obscureText: true,
//                 maxLength: 6,
//                 decoration: InputDecoration(
//                   labelText: strings.adminPinLabel,
//                   errorText: _errorText,
//                   border: const OutlineInputBorder(),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _login,
//                   child: Text(strings.adminLoginButton),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
