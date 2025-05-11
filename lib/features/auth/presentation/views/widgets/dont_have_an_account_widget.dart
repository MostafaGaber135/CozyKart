import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/features/auth/presentation/views/signup_view.dart';
import 'package:furni_iti/core/utils/app_text_styles.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({super.key});
  static const String routeName = '/DontHaveAnAccountWidget';

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Don\'t have an account?',
            style: AppTextStyles.bold16.copyWith(color: Color(0xFF949D9E)),
          ),
          TextSpan(
            text: ' ',
            style: AppTextStyles.bold16.copyWith(color: Color(0xFF616A6B)),
          ),
          TextSpan(
            text: 'Sign Up',
            style: AppTextStyles.bold19.copyWith(
              color: AppColors.primaryAccent,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacementNamed(
                      context,
                      SignupView.routeName,
                    );
                  },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
