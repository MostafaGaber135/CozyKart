// ✅ Updated Theme Colors and Fonts for Furniture App UI Style

import 'package:flutter/material.dart';

class AppColors {
  static const Color lightBackground = Color(0xFFEDEDED);
  static const Color primaryAccent = Color(0xFF3B4E54);
  static const Color hintGrey = Color(0xFF949D9E);
  static const Color secondaryText = Color(0xFF4E5456);
  static const Color unselectedNav = Color(0xFFA5B5B5);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkInputFill = Color(0xFF2C2C2C);
  static const Color darkNavBackground = Color(0xFF1F1F1F);
  static const Color darkText = Color(0xFFD7DBE0);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.primaryAccent,
    hintColor: AppColors.hintGrey,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryAccent,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.primaryAccent,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryAccent,
      ),
      bodyMedium: TextStyle(fontSize: 16, color: AppColors.secondaryText),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryAccent,
        shape: StadiumBorder(),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primaryAccent,
      unselectedItemColor: AppColors.unselectedNav,
      showUnselectedLabels: true,
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primaryAccent,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkInputFill,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    textTheme: ThemeData.dark().textTheme.copyWith(
      bodyMedium: const TextStyle(color: AppColors.darkText),
      headlineMedium: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      labelLarge: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryAccent,
        shape: StadiumBorder(),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkNavBackground,
      selectedItemColor: AppColors.darkText,
      unselectedItemColor: Colors.grey,
    ),
  );
}
