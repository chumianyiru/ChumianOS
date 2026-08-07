import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  String _currentTheme = 'sakura';

  ThemeMode get themeMode => _themeMode;
  String get currentTheme => _currentTheme;
  List<Map<String, dynamic>> get themes => AppTheme.themeList;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final mode = prefs.getString('theme_mode') ?? 'system';
    _themeMode = ThemeMode.values.firstWhere(
      (e) => e.name == mode,
      orElse: () => ThemeMode.system,
    );
    _currentTheme = prefs.getString('current_theme') ?? 'sakura';
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', mode.name);
    notifyListeners();
  }

  Future<void> setTheme(String themeName) async {
    _currentTheme = themeName;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_theme', themeName);
    notifyListeners();
  }

  Future<void> nextTheme() async {
    final themeNames = themes.map((t) => t['name'] as String).toList();
    final currentIndex = themeNames.indexOf(_currentTheme);
    final nextIndex = (currentIndex + 1) % themeNames.length;
    await setTheme(themeNames[nextIndex]);
  }
}
