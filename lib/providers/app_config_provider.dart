import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigProvider extends ChangeNotifier {
  String appLanguage = 'en';
  ThemeMode appTheme = ThemeMode.light;

  AppConfigProvider() {
    _loadPreferences();
  }

  Future<void> changeLanguage(String newLanguage) async {
    if (appLanguage == newLanguage) {
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();

    // Save the new language preference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('appLanguage', appLanguage);
  }

  Future<void> changeTheme(ThemeMode newMode) async {
    if (appTheme == newMode) {
      return;
    }
    appTheme = newMode;
    notifyListeners();

    // Save the new theme preference
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('appTheme', appTheme == ThemeMode.dark ? 'dark' : 'light');
  }

  bool isDarkMode() {
    return appTheme == ThemeMode.dark;
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    appLanguage = prefs.getString('appLanguage') ?? 'en';

    String? themeString = prefs.getString('appTheme');
    if (themeString != null) {
      appTheme = themeString == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }

    notifyListeners();
  }
}

