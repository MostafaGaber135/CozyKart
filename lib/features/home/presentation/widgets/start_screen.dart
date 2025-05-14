import 'package:flutter/material.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
import 'package:furni_iti/core/utils/app_text_styles.dart';
import 'package:furni_iti/features/onboarding/presentation/views/onboarding_views.dart';
import 'package:furni_iti/core/widgets/custom_elevated_button.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  static const String routeName = '/StartScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/splash_screen.gif'),
              Text(
                'FurniITI',
                style: AppTextStyles.bold32.copyWith(
                  color: AppColors.primaryAccent,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Find your perfect furniture for your home',
                style: AppTextStyles.semiBold16.copyWith(color: Colors.grey),
              ),
              Spacer(),
              CustomElevatedButton(
                title: 'get started'.toUpperCase(),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    OnBoardingPageView.routeName,
                  );
                },
              ),
              SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
