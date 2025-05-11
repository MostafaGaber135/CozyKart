import 'package:flutter/material.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/utils/app_text_styles.dart';
import 'package:furni_iti/core/widgets/custom_elevated_button.dart';
import 'package:furni_iti/core/widgets/custom_text_form_field.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});
  static const String routeName = '/ForgotPassword';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    return Scaffold(
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
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.password_outlined,
                  size: 80,
                  color: AppColors.primaryAccent,
                ),
                const SizedBox(height: 42),
                Text(
                  'Forgot Password',
                  style: AppTextStyles.bold28.copyWith(
                    color: AppColors.primaryAccent,
                  ),
                ),
                const SizedBox(height: 42),
                Text(
                  textAlign: TextAlign.center,
                  'Enter your email address to reset your password',
                  style: AppTextStyles.bold19.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
                const SizedBox(height: 42),

                CustomTextFormField(
                  controller: emailController,
                  hintText: 'Email address',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 42),
                CustomElevatedButton(title: 'RESET PASSWORD', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
