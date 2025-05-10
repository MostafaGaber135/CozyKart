import 'package:flutter/material.dart';
import 'package:furni_iti/core/network/dio_helper.dart';
import 'package:furni_iti/core/services/shared_preferences_singleton.dart';
import 'package:furni_iti/core/utils/app_theme.dart';
import 'package:furni_iti/features/auth/presentation/views/login_view.dart';
import 'package:furni_iti/features/auth/presentation/views/signup_view.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/dont_have_an_account_widget.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/forgot_password.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/otp_verification.dart';
import 'package:furni_iti/features/home/presentation/pages/home_screen.dart';
import 'package:furni_iti/features/onboarding/presentation/views/onboarding_views.dart';
import 'package:furni_iti/features/splash/presentation/splash_screen.dart';
import 'package:furni_iti/features/home/presentation/widgets/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesSingleton.init();
  DioHelper.init();
  runApp(FurniITI());
}

class FurniITI extends StatelessWidget {
  const FurniITI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        StartScreen.routeName: (context) => const StartScreen(),
        OnBoardingPageView.routeName: (context) => OnBoardingPageView(),
        LoginView.routeName: (context) => LoginView(),
        SignupView.routeName: (context) => SignupView(),
        ForgotPassword.routeName: (context) => ForgotPassword(),
        OtpVerification.routeName: (context) => OtpVerification(),
        DontHaveAnAccountWidget.routeName:
            (context) => DontHaveAnAccountWidget(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: LoginView(),
      initialRoute: SplashScreen.routeName,
    );
  }
}
