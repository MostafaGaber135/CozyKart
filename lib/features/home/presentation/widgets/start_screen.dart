import 'package:flutter/material.dart';
import 'package:cozykart/core/utils/app_colors.dart';
import 'package:cozykart/core/utils/app_text_styles.dart';
import 'package:cozykart/core/widgets/primary_button.dart';
import 'package:cozykart/features/onboarding/presentation/views/onboarding_views.dart';
import 'package:cozykart/generated/l10n.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  static const String routeName = '/StartScreen';

  @override
  Widget build(BuildContext context) {
    final local = S.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/splash_screen.gif'),
              Text(
                'ℂ𝑜𝓏𝘺𝐾𝓪𝕣𝘵',
                style: AppTextStyles.bold32.copyWith(
                  color: AppColors.primaryAccent,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                local.splashTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.semiBold16.copyWith(color: Colors.grey),
              ),
              const Spacer(),
              PrimaryButton(
                title: local.getStarted.toUpperCase(),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    OnBoardingPageView.routeName,
                  );
                },
              ),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
