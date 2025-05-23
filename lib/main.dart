import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cozykart/core/services/shared_prefs_helper.dart';
import 'package:cozykart/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:cozykart/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cozykart/core/network/dio_helper.dart';
import 'package:cozykart/core/utils/app_theme.dart';
import 'package:cozykart/core/widgets/main_screen.dart';
import 'package:cozykart/features/about/presentation/views/about_view.dart';
import 'package:cozykart/features/auth/presentation/views/login_view.dart';
import 'package:cozykart/features/auth/presentation/views/signup_view.dart';
import 'package:cozykart/features/auth/presentation/views/widgets/dont_have_an_account_widget.dart';
import 'package:cozykart/features/auth/presentation/views/widgets/forgot_password.dart';
import 'package:cozykart/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:cozykart/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:cozykart/features/blog/presentation/cubit/blog_cubit.dart';
import 'package:cozykart/features/blog/presentation/views/blog_view.dart';
import 'package:cozykart/features/contact_us/presentation/views/contact_us_view.dart';
import 'package:cozykart/features/home/presentation/pages/home_screen.dart';
import 'package:cozykart/features/home/presentation/widgets/start_screen.dart';
import 'package:cozykart/features/onboarding/presentation/views/onboarding_views.dart';
import 'package:cozykart/features/profile/presentation/views/widgets/help_page.dart';
import 'package:cozykart/features/profile/presentation/views/widgets/privacy_page.dart';
import 'package:cozykart/features/settings/domain/settings_provider.dart';
import 'package:cozykart/features/settings/presentation/views/settings_view.dart';
import 'package:cozykart/features/shop/data/repositories/product_repository.dart';
import 'package:cozykart/features/shop/presentation/cubit/product_cubit.dart';
import 'package:cozykart/features/shop/presentation/views/shop_view.dart';
import 'package:cozykart/features/splash/presentation/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.init();
  DioHelper.init();
  final prefs = await SharedPreferences.getInstance();
  final token = await SharedPrefsHelper.getToken();
  final hasSeenOnboarding = SharedPrefsHelper.getBool('onBoardingSeen');
  log("All Keys: ${prefs.getKeys()}");
  log("userId: ${prefs.getString("userId")}");

  Widget startWidget;
  if (!hasSeenOnboarding) {
    startWidget = const SplashScreen();
  } else if (token != null && !JwtDecoder.isExpired(token)) {
    startWidget = const MainScreen();
  } else {
    startWidget = SplashScreen();
  }

  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return CozyKart(startWidget: startWidget);
      },
    ),
  );
}

class CozyKart extends StatelessWidget {
  final Widget startWidget;
  const CozyKart({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final provider = SettingsProvider();
            provider.loadLanguage();
            return provider;
          },
        ),
        BlocProvider(create: (_) => ProfileCubit()..loadUser()),
        BlocProvider(
          create:
              (_) =>
                  BlogCubit(BlogRepositoryImpl(BlogRemoteDataSource()))
                    ..getPosts(),
        ),
        BlocProvider(create: (_) => ProductCubit(ProductRepository())),
      ],
      child: Builder(
        builder: (context) {
          final settingsProvider = Provider.of<SettingsProvider>(context);
          return MaterialApp(
            locale: settingsProvider.currentLanguage, 
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            themeMode: settingsProvider.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            home: startWidget,
            routes: {
              SplashScreen.routeName: (context) => SplashScreen(),
              HomeScreen.routeName: (context) => const HomeScreen(),
              StartScreen.routeName: (context) => const StartScreen(),
              OnBoardingPageView.routeName:
                  (context) => const OnBoardingPageView(),
              LoginView.routeName: (context) => LoginView(),
              SignupView.routeName: (context) => SignupView(),
              ForgotPassword.routeName: (context) => ForgotPassword(),
              DontHaveAnAccountWidget.routeName:
                  (context) => const DontHaveAnAccountWidget(),
              BlogView.routeName: (context) => BlogView(),
              ShopView.routeName: (context) => ShopView(),
              AboutView.routeName: (context) => AboutView(),
              ContactUsView.routeName: (context) => ContactUsView(),
              SettingsView.routeName: (context) => SettingsView(),
              MainScreen.routeName: (context) => const MainScreen(),
              PrivacyPage.routeName: (context) => const PrivacyPage(),
              HelpPage.routeName: (context) => const HelpPage(),
            },
          );
        },
      ),
    );
  }
}
