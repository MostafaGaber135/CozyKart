import 'dart:async';
import 'package:flutter/material.dart';
import 'package:furni_iti/features/auth/presentation/views/login_view.dart';
import 'package:lottie/lottie.dart';
import 'package:furni_iti/core/services/shared_preferences_singleton.dart';
import 'package:furni_iti/features/onboarding/presentation/views/onboarding_views.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = '/SplashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterSplash();
  }

  Future<void> _navigateAfterSplash() async {
    await Future.delayed(const Duration(seconds: 5));
    final seen = SharedPreferencesSingleton.getBool('onBoardingSeen');
    if (!mounted) return;
    if (seen) {
      Navigator.pushReplacementNamed(context, LoginView.routeName);
    } else {
      Navigator.pushReplacementNamed(context, OnBoardingPageView.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Center(child: Lottie.asset('assets/images/Animation.json')),
      ),
    );
  }
}
