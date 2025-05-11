import 'package:flutter/material.dart';
import 'package:furni_iti/core/utils/app_colors.dart';
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
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryAccent,
                  fontFamily: 'Poppins',
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Find your perfect furniture for your home',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.primaryAccent,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
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
