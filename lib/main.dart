import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:furni_iti/core/network/dio_helper.dart';
import 'package:furni_iti/core/services/shared_preferences_singleton.dart';
import 'package:furni_iti/core/utils/app_theme.dart';
import 'package:furni_iti/core/widgets/main_screen.dart';
import 'package:furni_iti/features/about/presentation/views/about_view.dart';
import 'package:furni_iti/features/auth/presentation/views/login_view.dart';
import 'package:furni_iti/features/auth/presentation/views/signup_view.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/dont_have_an_account_widget.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/forgot_password.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/otp_verification.dart';
import 'package:furni_iti/features/blog/presentation/views/blog_view.dart';
import 'package:furni_iti/features/contact_us/presentation/views/contact_us_view.dart';
import 'package:furni_iti/features/home/presentation/pages/home_screen.dart';
import 'package:furni_iti/features/onboarding/presentation/views/onboarding_views.dart';
import 'package:furni_iti/features/settings/domain/settings_provider.dart';
import 'package:furni_iti/features/settings/presentation/views/settings_view.dart';
import 'package:furni_iti/features/shop/presentation/views/shop_view.dart';
import 'package:furni_iti/features/splash/presentation/splash_screen.dart';
import 'package:furni_iti/features/home/presentation/widgets/start_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("dotenv file not found or failed to load: $e");
  }

  await SharedPreferencesSingleton.init();
  DioHelper.init();

  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const FurniITI(),
    ),
  );
}

class FurniITI extends StatelessWidget {
  const FurniITI({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: settingsProvider.themeMode,
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
        ShopView.routeName: (context) => ShopView(),
        BlogView.routeName: (context) => BlogView(),
        AboutView.routeName: (context) => AboutView(),
        ContactUsView.routeName: (context) => ContactUsView(),
        SettingsView.routeName: (context) => SettingsView(),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const MainScreen(),
      initialRoute: MainScreen.routeName,
    );
  }
}
