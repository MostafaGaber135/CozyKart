import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/utils/app_text_styles.dart';
import 'package:furni_iti/core/widgets/custom_input_field.dart';
import 'package:furni_iti/core/widgets/primary_button.dart';
import 'package:furni_iti/generated/l10n.dart';

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
                  size: 80.sp,
                  color: AppColors.primaryAccent,
                ),
                SizedBox(height: 42.h),
                Text(
                  S.of(context).forgotPassword,
                  style: AppTextStyles.bold28.copyWith(
                    color: AppColors.primaryAccent,
                  ),
                ),
                SizedBox(height: 42.h),
                Text(
                  textAlign: TextAlign.center,
                  S.of(context).enterEmailToReset,
                  style: AppTextStyles.bold19.copyWith(
                    color: AppColors.secondaryText,
                  ),
                ),
                SizedBox(height: 42.h),

                CustomInputField(
                  controller: emailController,
                  hintText: S.of(context).emailAddress,
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 42.h),
                PrimaryButton(
                  title: S.of(context).resetPassword,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
