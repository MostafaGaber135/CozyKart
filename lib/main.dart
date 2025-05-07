import 'package:flutter/material.dart';
import 'package:furni_iti/core/services/shared_preferences_singleton.dart';
import 'package:furni_iti/core/utils/app_theme.dart';
import 'package:furni_iti/features/home/presentation/pages/home_screen.dart';
import 'package:furni_iti/features/onboarding/presentation/views/onboarding_views.dart';
import 'package:furni_iti/features/splash/presentation/splash_screen.dart';
import 'package:furni_iti/features/home/presentation/widgets/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesSingleton.init();

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
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: SplashScreen(),
      initialRoute: SplashScreen.routeName,
    );
  }
}
