import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:furni_iti/core/utils/app_theme.dart';
import 'package:furni_iti/features/auth/presentation/views/login_view.dart';
import 'package:furni_iti/core/utils/app_text_styles.dart';

class AlreadyHaveAnAccountWidget extends StatelessWidget {
  const AlreadyHaveAnAccountWidget({super.key});
  static const String routeName = '/AlreadyHaveAnAccountWidget';

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Already have an account?',
            style: AppTextStyles.bold16.copyWith(color: Color(0xFF949D9E)),
          ),
          TextSpan(
            text: ' ',
            style: AppTextStyles.bold16.copyWith(color: Color(0xFF616A6B)),
          ),
          TextSpan(
            text: 'Login',
            style: AppTextStyles.bold19.copyWith(
              color: AppColors.primaryAccent,
            ),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.pushReplacementNamed(
                      context,
                      LoginView.routeName,
                    );
                  },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
