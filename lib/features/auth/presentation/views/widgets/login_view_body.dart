import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/widgets/custom_button.dart';
import 'package:furni_iti/core/widgets/custom_outlined_button.dart';
import 'package:furni_iti/core/widgets/custom_text_form_field.dart';
import 'package:furni_iti/core/widgets/main_screen.dart';
import 'package:furni_iti/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:furni_iti/features/auth/presentation/cubit/auth_state.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/dont_have_an_account_widget.dart';
import 'package:furni_iti/core/utils/app_text_styles.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/forgot_password.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:furni_iti/features/settings/domain/settings_provider.dart';
import 'package:provider/provider.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void showToast(String msg, {bool success = false}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: success ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  bool _isValidEmail(String email) {
    return RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(email);
  }

  void _submitLogin(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    log("EMAIL SENT: ${emailController.text}");
    log("PASSWORD SENT: ${passwordController.text}");

    if (email.isEmpty || password.isEmpty) {
      showToast("Email and password cannot be empty");
      return;
    }

    if (!_isValidEmail(email)) {
      showToast("Invalid email format");
      return;
    }

    if (password.length < 6) {
      showToast("Password must be at least 6 characters");
      return;
    }

    context.read<AuthCubit>().login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showToast(state.message);
        } else if (state is AuthSuccess) {
          showToast("Login Successful", success: true);
          Future.delayed(const Duration(seconds: 1), () {
            if (!context.mounted) return;
            Navigator.pushReplacementNamed(context, MainScreen.routeName);
          });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            padding: EdgeInsets.only(
              left: 24,
              right: 24,
              top: 44,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 80,
                    color: AppColors.primaryAccent,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Login',
                    style: AppTextStyles.bold28.copyWith(
                      color: AppColors.primaryAccent,
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomTextFormField(
                    controller: emailController,
                    hintText: 'Email address',
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  CustomTextFormField(
                    controller: passwordController,
                    hintText: 'Password',
                    textInputType: TextInputType.visiblePassword,
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: const Color(0xFFC9CECF),
                      ),
                      onPressed: _togglePasswordVisibility,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          ForgotPassword.routeName,
                        );
                      },
                      child: Text(
                        'Forgot password?',
                        style: AppTextStyles.regular16.copyWith(
                          color:
                              settingsProvider.isDark
                                  ? Colors.white
                                  : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  CustomButton(
                    onPressed: () => _submitLogin(context),
                    text: 'LOG IN',
                  ),
                  const SizedBox(height: 32),
                  const DontHaveAnAccountWidget(),
                  const SizedBox(height: 32),
                  const OrDivider(),
                  const SizedBox(height: 32),
                  CustomOutlinedButton(
                    onPressed: () {},
                    textBtn: 'LOG IN WITH GOOGLE',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
