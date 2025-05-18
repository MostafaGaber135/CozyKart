import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furni_iti/core/widgets/custom_text_button.dart';
import 'package:furni_iti/core/widgets/custom_input_field.dart';
import 'package:furni_iti/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:furni_iti/features/auth/presentation/cubit/auth_state.dart';
import 'package:furni_iti/features/auth/presentation/views/login_view.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/already_have_an_account_widget.dart';

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
      fontSize: 16.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          showToast(
            "Account created successfully. Please login.",
            success: true,
          );

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
              left: 24,
              right: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/person.png',
                  height: 180,
                  width: 180,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: englishNameController,
                  hintText: 'Full Name',
                  textInputType: TextInputType.name,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: arabicNameController,
                  hintText: 'الاسم الكامل (عربي)',
                  textInputType: TextInputType.name,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: emailController,
                  hintText: 'Email',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                CustomInputField(
                  controller: passwordController,
                  hintText: 'Password',
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
                const SizedBox(height: 16),
                CustomInputField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
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
                const SizedBox(height: 24),
                CustomTextButton(
                  text: 'Register',
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
                      showToast("All fields are required");
                      return;
                    }

                    if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(email)) {
                      showToast("Invalid email format");
                      return;
                    }

                    if (password.length < 6) {
                      showToast("Password must be at least 6 characters");
                      return;
                    }

                    if (confirm != password) {
                      showToast("Passwords do not match");
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
