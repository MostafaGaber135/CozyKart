import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cozykart/core/services/shared_prefs_helper.dart';
import 'package:cozykart/features/home/presentation/widgets/start_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:cozykart/features/onboarding/presentation/views/onboarding_views.dart';

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
    final seen = SharedPrefsHelper.getBool('onBoardingSeen');
    if (!mounted) return;
    if (seen) {
      Navigator.pushReplacementNamed(context, StartScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, OnBoardingPageView.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 32.h),
        child: Center(child: Lottie.asset('assets/images/Animation.json')),
      ),
    );
  }
}
