import 'package:flutter/material.dart';
import 'package:furni_iti/core/utils/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.primaryAccent,
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      backgroundColor: AppColors.lightBackground,
      iconTheme: IconThemeData(color: AppColors.primaryAccent),
      titleTextStyle: TextStyle(
        color: AppColors.primaryAccent,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardColor: AppColors.lightSurface,
    dividerColor: AppColors.lightBorder,
    colorScheme: ColorScheme.light(
      primary: AppColors.primaryAccent,
      surfaceBright: AppColors.lightBackground,
      surface: AppColors.lightSurface,
      error: AppColors.lightError,
      onPrimary: Colors.white,
      onSurface: AppColors.secondaryText,
      onSurfaceVariant: AppColors.secondaryText,
      onError: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightBackground,
      selectedItemColor: AppColors.primaryAccent,
      unselectedItemColor: AppColors.unselectedNav,
      showUnselectedLabels: true,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primaryAccent,
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppColors.darkBackground,
      iconTheme: IconThemeData(color: AppColors.darkText),
      titleTextStyle: TextStyle(
        color: AppColors.darkText,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    cardColor: AppColors.darkSurface,
    dividerColor: AppColors.darkBorder,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryAccent,
      surfaceBright: AppColors.darkBackground,
      surface: AppColors.darkSurface,
      error: AppColors.darkError,
      onPrimary: Colors.white,
      onSurface: AppColors.darkText,
      onSurfaceVariant: AppColors.darkText,
      onError: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkNavBackground,
      selectedItemColor: AppColors.primaryAccent,
      unselectedItemColor: AppColors.darkUnselectedNav,
      showUnselectedLabels: true,
    ),
  );
}
