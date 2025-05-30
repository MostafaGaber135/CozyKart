import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/widgets/custom_text_button.dart';
import 'package:furni_iti/core/widgets/custom_input_field.dart';
import 'package:furni_iti/core/widgets/main_screen.dart';
import 'package:furni_iti/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:furni_iti/features/auth/presentation/cubit/auth_state.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/dont_have_an_account_widget.dart';
import 'package:furni_iti/core/utils/app_text_styles.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/forgot_password.dart';
import 'package:furni_iti/features/settings/domain/settings_provider.dart';
import 'package:furni_iti/generated/l10n.dart';
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
      showToast(S.of(context).emptyFields);
      return;
    }

    if (!_isValidEmail(email)) {
      showToast(S.of(context).invalidEmail);
      return;
    }

    if (password.length < 6) {
      showToast(S.of(context).shortPassword);
      return;
    }

    context.read<AuthCubit>().login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) async {
        if (state is AuthFailure) {
          showToast(state.message);
        } else if (state is AuthSuccess) {
          showToast(S.of(context).loginSuccess, success: true);
          await SharedPrefsHelper.saveUserId(state.user.id);

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
              left: 24.w,
              right: 24.w,
              top: 44.h,
              bottom: (MediaQuery.of(context).viewInsets.bottom + 24).h,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 80.sp,
                    color: AppColors.primaryAccent,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    S.of(context).login,
                    style: AppTextStyles.bold28.copyWith(
                      color: AppColors.primaryAccent,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  CustomInputField(
                    controller: emailController,
                    hintText: S.of(context).emailAddress,
                    textInputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 16.h),
                  CustomInputField(
                    controller: passwordController,
                    hintText: S.of(context).password,
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
                  SizedBox(height: 12.h),
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
                        S.of(context).forgotPassword,
                        style: AppTextStyles.regular16.copyWith(
                          color:
                              settingsProvider.isDark
                                  ? Colors.white
                                  : Colors.black54,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.h),
                  CustomTextButton(
                    onPressed: () => _submitLogin(context),
                    text: S.of(context).logIn,
                  ),
                  SizedBox(height: 32.h),
                  const DontHaveAnAccountWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
