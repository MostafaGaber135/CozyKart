import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:cozykart/core/utils/app_colors.dart';
import 'package:cozykart/features/auth/presentation/views/signup_view.dart';
import 'package:cozykart/core/utils/app_text_styles.dart';
import 'package:cozykart/features/settings/domain/settings_provider.dart';
import 'package:cozykart/generated/l10n.dart';
import 'package:provider/provider.dart';

class DontHaveAnAccountWidget extends StatelessWidget {
  const DontHaveAnAccountWidget({super.key});
  static const String routeName = '/DontHaveAnAccountWidget';

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: S.of(context).dontHaveAccount,
            style: AppTextStyles.bold16.copyWith(
              color:
                  settingsProvider.isDark
                      ? AppColors.darkText
                      : Color(0xFF949D9E),
            ),
          ),
          TextSpan(
            text: ' ',
            style: AppTextStyles.bold16.copyWith(
              color:
                  settingsProvider.isDark
                      ? AppColors.darkText
                      : Color(0xFF949D9E),
            ),
          ),
          TextSpan(
            text: S.of(context).signUp,
            style: AppTextStyles.bold19.copyWith(
              color:
                  settingsProvider.isDark
                      ? AppColors.primaryAccent
                      : AppColors.primaryAccent,
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
