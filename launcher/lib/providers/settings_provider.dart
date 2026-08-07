import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const platform = MethodChannel('com.chumianos.launcher/system');

  bool _developerMode = false;
  String _iconTheme = 'default';
  int _gridColumns = 4;
  double _iconSize = 56;
  bool _showStatusBar = false;
  bool _showAppLabels = true;
  double _wallpaperBlur = 0;
  String _animationSpeed = 'normal';
  bool _notificationsExpanded = false;
  bool _isEditMode = false;

  bool get developerMode => _developerMode;
  String get iconTheme => _iconTheme;
  int get gridColumns => _gridColumns;
  double get iconSize => _iconSize;
  bool get showStatusBar => _showStatusBar;
  bool get showAppLabels => _showAppLabels;
  double get wallpaperBlur => _wallpaperBlur;
  String get animationSpeed => _animationSpeed;
  bool get notificationsExpanded => _notificationsExpanded;
  bool get isEditMode => _isEditMode;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _iconTheme = prefs.getString('icon_theme') ?? 'default';
    _gridColumns = prefs.getInt('grid_columns') ?? 4;
    _iconSize = prefs.getDouble('icon_size') ?? 56;
    _showStatusBar = prefs.getBool('show_status_bar') ?? false;
    _showAppLabels = prefs.getBool('show_app_labels') ?? true;
    _wallpaperBlur = prefs.getDouble('wallpaper_blur') ?? 0;
    _animationSpeed = prefs.getString('animation_speed') ?? 'normal';
    notifyListeners();
  }

  void setIconTheme(String theme) async {
    _iconTheme = theme;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('icon_theme', theme);
    notifyListeners();
  }

  void setGridColumns(int cols) {
    _gridColumns = cols;
    _saveSetting('grid_columns', cols);
    notifyListeners();
  }

  void setIconSize(double size) {
    _iconSize = size;
    _saveSetting('icon_size', size);
    notifyListeners();
  }

  void setShowStatusBar(bool show) {
    _showStatusBar = show;
    _saveSetting('show_status_bar', show);
    notifyListeners();
  }

  void toggleStatusBar() {
    _showStatusBar = !_showStatusBar;
    _saveSetting('show_status_bar', _showStatusBar);
    notifyListeners();
  }

  void setShowAppLabels(bool show) {
    _showAppLabels = show;
    _saveSetting('show_app_labels', show);
    notifyListeners();
  }

  void toggleAppLabels() {
    _showAppLabels = !_showAppLabels;
    _saveSetting('show_app_labels', _showAppLabels);
    notifyListeners();
  }

  void setWallpaperBlur(double blur) {
    _wallpaperBlur = blur;
    _saveSetting('wallpaper_blur', blur);
    notifyListeners();
  }

  void setAnimationSpeed(String speed) {
    _animationSpeed = speed;
    _saveSetting('animation_speed', speed);
    notifyListeners();
  }

  void expandNotifications() {
    _notificationsExpanded = true;
    notifyListeners();
  }

  void collapseNotifications() {
    _notificationsExpanded = false;
    notifyListeners();
  }

  void toggleNotifications() {
    _notificationsExpanded = !_notificationsExpanded;
    notifyListeners();
  }

  void enterEditMode() {
    _isEditMode = true;
    notifyListeners();
  }

  void exitEditMode() {
    _isEditMode = false;
    notifyListeners();
  }

  void toggleEditMode() {
    _isEditMode = !_isEditMode;
    notifyListeners();
  }

  Future<void> _saveSetting(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    }
  }

  Future<void> rebootSystem() async {
    try {
      await platform.invokeMethod('rebootSystem');
    } catch (e) {
      debugPrint('Error rebooting: $e');
    }
  }

  Future<void> shutdownSystem() async {
    try {
      await platform.invokeMethod('shutdownSystem');
    } catch (e) {
      debugPrint('Error shutting down: $e');
    }
  }
}
