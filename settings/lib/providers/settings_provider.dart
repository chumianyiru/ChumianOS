import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const MethodChannel _channel = MethodChannel('com.chumianos.settings/system');

  bool _developerMode = false;
  bool _isLoading = true;

  bool get developerMode => _developerMode;
  bool get isLoading => _isLoading;

  SettingsProvider() {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _developerMode = prefs.getBool('developer_mode') ?? false;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleDeveloperMode() async {
    _developerMode = !_developerMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('developer_mode', _developerMode);
    
    try {
      _channel.invokeMethod('enableDeveloperOptions');
    } catch (_) {}
    
    notifyListeners();
  }

  Future<void> showEasterEgg() async {
    try {
      await _channel.invokeMethod('showAndroidEasterEgg');
    } catch (_) {}
  }

  Future<void> setBrightness(double value) async {
    try {
      await _channel.invokeMethod('setBrightness', {'value': value});
    } catch (_) {}
  }

  Future<void> setVolume(double value) async {
    try {
      await _channel.invokeMethod('setVolume', {'value': value});
    } catch (_) {}
  }

  Future<void> reboot() async {
    try {
      await _channel.invokeMethod('rebootSystem');
    } catch (_) {}
  }

  Future<void> shutdown() async {
    try {
      await _channel.invokeMethod('shutdownSystem');
    } catch (_) {}
  }
}
