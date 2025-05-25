import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furni_iti/core/widgets/custom_text_button.dart';
import 'package:furni_iti/core/widgets/custom_input_field.dart';
import 'package:furni_iti/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:furni_iti/features/auth/presentation/cubit/auth_state.dart';
import 'package:furni_iti/features/auth/presentation/views/login_view.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/already_have_an_account_widget.dart';
import 'package:furni_iti/generated/l10n.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final englishNameController = TextEditingController();
  final arabicNameController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
  }

  void showToast(String msg, {bool success = false}) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: success ? Colors.green : Colors.red,
      textColor: Colors.white,
      fontSize: 16.sp,
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          showToast(local.registerSuccess, success: true);

          Future.microtask(() {
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginView()),
                (route) => false,
              );
            }
          });
        }

        if (state is AuthFailure) {
          showToast(state.message);
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
              bottom: (MediaQuery.of(context).viewInsets.bottom + 24).h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/person.png',
                  height: 180.h,
                  width: 180.w,
                ),
                SizedBox(height: 16.h),
                CustomInputField(
                  controller: englishNameController,
                  hintText: local.fullName,
                  textInputType: TextInputType.name,
                ),
                SizedBox(height: 16.h),
                CustomInputField(
                  controller: arabicNameController,
                  hintText: local.fullNameAr,
                  textInputType: TextInputType.name,
                ),
                SizedBox(height: 16.h),
                CustomInputField(
                  controller: emailController,
                  hintText: local.emailAddress,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 16.h),
                CustomInputField(
                  controller: passwordController,
                  hintText: local.password,
                  obscureText: _obscurePassword,
                  textInputType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
                SizedBox(height: 16.h),
                CustomInputField(
                  controller: confirmPasswordController,
                  hintText: local.confirmPassword,
                  obscureText: _obscureConfirmPassword,
                  textInputType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: _toggleConfirmPasswordVisibility,
                  ),
                ),
                SizedBox(height: 24.h),
                CustomTextButton(
                  text: local.signUp,
                  onPressed: () {
                    final nameEn = englishNameController.text.trim();
                    final nameAr = arabicNameController.text.trim();
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    final confirm = confirmPasswordController.text.trim();

                    if (nameEn.isEmpty ||
                        nameAr.isEmpty ||
                        email.isEmpty ||
                        password.isEmpty ||
                        confirm.isEmpty) {
                      showToast(local.emptyFields);
                      return;
                    }

                    if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(email)) {
                      showToast(local.invalidEmail);
                      return;
                    }

                    if (password.length < 6) {
                      showToast(local.shortPassword);
                      return;
                    }

                    if (confirm != password) {
                      showToast(local.passwordMismatch);
                      return;
                    }

                    context.read<AuthCubit>().register(
                      email: email,
                      password: password,
                      userName: {"en": nameEn, "ar": nameAr},
                    );
                  },
                ),
                const SizedBox(height: 16),
                const AlreadyHaveAnAccountWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
