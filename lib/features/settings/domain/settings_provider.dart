import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  static const String languageKey = 'language';

  bool get isDark => themeMode == ThemeMode.dark;
  static const String themeKey = 'theme_mode';

  SettingsProvider() {
    loadSettings();
    loadLanguage();
  }
  void changeTheme(ThemeMode selectedTheme) async {
    themeMode = selectedTheme;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      themeKey,
      selectedTheme == ThemeMode.dark ? 'dark' : 'light',
    );
  }

  Future<void> loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTheme = prefs.getString(themeKey);
    themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Locale? currentLanguage;

  Future<void> setLanguage(Locale newLanguage) async {
    currentLanguage = newLanguage;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(languageKey, [
      newLanguage.languageCode,
      newLanguage.countryCode ?? '',
    ]);
  }

  Future<void> loadLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedLanguage = prefs.getStringList(languageKey);
    if (savedLanguage != null) {
      currentLanguage = Locale(savedLanguage[0], savedLanguage[1]);
    }
    notifyListeners();
  }
}
