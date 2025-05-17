import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:furni_iti/core/services/shared_prefs_helper.dart';
import 'package:provider/provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:furni_iti/core/network/dio_helper.dart';
import 'package:furni_iti/core/utils/app_theme.dart';
import 'package:furni_iti/core/widgets/main_screen.dart';
import 'package:furni_iti/features/about/presentation/views/about_view.dart';
import 'package:furni_iti/features/auth/presentation/views/login_view.dart';
import 'package:furni_iti/features/auth/presentation/views/signup_view.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/dont_have_an_account_widget.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/forgot_password.dart';
import 'package:furni_iti/features/auth/presentation/views/widgets/otp_verification.dart';
import 'package:furni_iti/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:furni_iti/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:furni_iti/features/blog/presentation/cubit/blog_cubit.dart';
import 'package:furni_iti/features/blog/presentation/views/blog_view.dart';
import 'package:furni_iti/features/contact_us/presentation/views/contact_us_view.dart';
import 'package:furni_iti/features/home/presentation/pages/home_screen.dart';
import 'package:furni_iti/features/home/presentation/widgets/start_screen.dart';
import 'package:furni_iti/features/onboarding/presentation/views/onboarding_views.dart';
import 'package:furni_iti/features/profile/presentation/views/widgets/help_page.dart';
import 'package:furni_iti/features/profile/presentation/views/widgets/privacy_page.dart';
import 'package:furni_iti/features/settings/domain/settings_provider.dart';
import 'package:furni_iti/features/settings/presentation/views/settings_view.dart';
import 'package:furni_iti/features/shop/data/datasources/category_remote_datasource.dart';
import 'package:furni_iti/features/shop/data/repositories/category_repository_impl.dart';
import 'package:furni_iti/features/shop/data/repositories/product_repository.dart';
import 'package:furni_iti/features/shop/domain/usecases/get_categories.dart';
import 'package:furni_iti/features/shop/presentation/cubit/category_cubit.dart';
import 'package:furni_iti/features/shop/presentation/cubit/product_cubit.dart';
import 'package:furni_iti/features/shop/presentation/views/shop_view.dart';
import 'package:furni_iti/features/shop/presentation/views/widgets/product_tab_page.dart';
import 'package:furni_iti/features/splash/presentation/splash_screen.dart';

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
    startWidget = const OnBoardingPageView();
  } else if (token != null && !JwtDecoder.isExpired(token)) {
    startWidget = const SplashScreen();
  } else {
    startWidget = SplashScreen();
  }

  runApp(FurniITI(startWidget: startWidget));
}

class FurniITI extends StatelessWidget {
  final Widget startWidget;
  const FurniITI({super.key, required this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        BlocProvider(
          create:
              (_) =>
                  BlogCubit(BlogRepositoryImpl(BlogRemoteDataSource()))
                    ..getPosts(),
        ),
        BlocProvider(
          create: (_) => ProductCubit(ProductRepository())..getProducts(),
          child: const ProductsTabPage(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final settingsProvider = Provider.of<SettingsProvider>(context);
          return MaterialApp(
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
              OtpVerification.routeName: (context) => OtpVerification(),
              DontHaveAnAccountWidget.routeName:
                  (context) => const DontHaveAnAccountWidget(),
              ShopView.routeName: (context) {
                final dio = Dio();
                final remoteDataSource = CategoryRemoteDataSource(dio);
                final repository = CategoryRepositoryImpl(remoteDataSource);
                final getCategories = GetCategories(repository);

                return BlocProvider(
                  create:
                      (_) => CategoryCubit(getCategories)..fetchCategories(),
                  child: const ShopView(),
                );
              },
              BlogView.routeName: (context) => BlogView(),
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
