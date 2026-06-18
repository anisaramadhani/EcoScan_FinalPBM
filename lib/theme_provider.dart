import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void setTheme(String theme) {
    switch (theme) {
      case 'Terang':
        _themeMode = ThemeMode.light;
        break;

      case 'Gelap':
        _themeMode = ThemeMode.dark;
        break;

      case 'Otomatis':
        _themeMode = ThemeMode.system;
        break;

      default:
        _themeMode = ThemeMode.light;
    }

    notifyListeners();
  }
}