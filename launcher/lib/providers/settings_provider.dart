import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const platform = MethodChannel('com.chumianos.launcher/system');
  
  bool _developerMode = false;
  String _iconTheme = 'default';
  int _gridColumns = 4;
  double _iconSize = 64;
  bool _showStatusBar = false;
  bool _showAppLabels = true;
  double _wallpaperBlur = 0;
  String _animationSpeed = 'normal';
  
  bool get developerMode => _developerMode;
  String get iconTheme => _iconTheme;
  int get gridColumns => _gridColumns;
  double get iconSize => _iconSize;
  bool get showStatusBar => _showStatusBar;
  bool get showAppLabels => _showAppLabels;
  double get wallpaperBlur => _wallpaperBlur;
  String get animationSpeed => _animationSpeed;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _iconTheme = prefs.getString('icon_theme') ?? 'default';
    _gridColumns = prefs.getInt('grid_columns') ?? 4;
    _iconSize = prefs.getDouble('icon_size') ?? 64;
    _showStatusBar = prefs.getBool('show_status_bar') ?? false;
    _showAppLabels = prefs.getBool('show_app_labels') ?? true;
    _wallpaperBlur = prefs.getDouble('wallpaper_blur') ?? 0;
    _animationSpeed = prefs.getString('animation_speed') ?? 'normal';
    await _checkDeveloperMode();
    notifyListeners();
  }

  Future<void> _checkDeveloperMode() async {
    try {
      _developerMode = await platform.invokeMethod('isDeveloperOptionsEnabled');
    } catch (e) {
      _developerMode = false;
    }
  }

  Future<void> toggleDeveloperMode() async {
    try {
      if (_developerMode) {
        await platform.invokeMethod('disableDeveloperOptions');
      } else {
        await platform.invokeMethod('enableDeveloperOptions');
      }
      await _checkDeveloperMode();
      notifyListeners();
    } catch (e) {
      debugPrint('Error toggling dev mode: $e');
    }
  }

  Future<void> showEasterEgg() async {
    await platform.invokeMethod('showAndroidEasterEgg');
  }

  void setIconTheme(String theme) async {
    _iconTheme = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('icon_theme', theme);
    notifyListeners();
  }

  void setGridColumns(int cols) async {
    _gridColumns = cols;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('grid_columns', cols);
    notifyListeners();
  }

  void setIconSize(double size) async {
    _iconSize = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('icon_size', size);
    notifyListeners();
  }

  void setShowStatusBar(bool show) async {
    _showStatusBar = show;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('show_status_bar', show);
    if (show) {
      await platform.invokeMethod('showNavigationBar');
    } else {
      await platform.invokeMethod('hideNavigationBar');
    }
    notifyListeners();
  }

  void setShowAppLabels(bool show) async {
    _showAppLabels = show;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('show_app_labels', show);
    notifyListeners();
  }

  void setWallpaperBlur(double blur) async {
    _wallpaperBlur = blur;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('wallpaper_blur', blur);
    notifyListeners();
  }

  void setAnimationSpeed(String speed) async {
    _animationSpeed = speed;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('animation_speed', speed);
    notifyListeners();
  }

  Future<void> rebootSystem() async {
    await platform.invokeMethod('rebootSystem');
  }

  Future<void> shutdownSystem() async {
    await platform.invokeMethod('shutdownSystem');
  }

  Future<void> expandNotifications() async {
    await platform.invokeMethod('expandNotifications');
  }

  Future<void> expandQuickSettings() async {
    await platform.invokeMethod('expandQuickSettings');
  }
}
