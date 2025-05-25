import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/features/auth/presentation/views/login_view.dart';
import 'package:furni_iti/core/utils/app_text_styles.dart';
import 'package:furni_iti/generated/l10n.dart';

class AlreadyHaveAnAccountWidget extends StatelessWidget {
  const AlreadyHaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: S.of(context).alreadyHaveAccount,
            style: AppTextStyles.bold16.copyWith(
              color: const Color(0xFF949D9E),
            ),
          ),
          TextSpan(
            text: ' ',
            style: AppTextStyles.bold16.copyWith(
              color: const Color(0xFF616A6B),
            ),
          ),
          TextSpan(
            text: S.of(context).login,
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
