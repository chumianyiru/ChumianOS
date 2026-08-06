import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_apps/device_apps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInfo {
  final String packageName;
  final String appName;
  final String? iconBase64;
  final bool isSystemApp;
  final bool isEnabled;
  final List<String> shortcuts;
  int? category;

  AppInfo({
    required this.packageName,
    required this.appName,
    this.iconBase64,
    this.isSystemApp = false,
    this.isEnabled = true,
    this.shortcuts = const [],
    this.category,
  });

  Map<String, dynamic> toJson() => {
    'packageName': packageName,
    'appName': appName,
    'iconBase64': iconBase64,
    'isSystemApp': isSystemApp,
    'isEnabled': isEnabled,
    'shortcuts': shortcuts,
    'category': category,
  };

  factory AppInfo.fromJson(Map<String, dynamic> json) => AppInfo(
    packageName: json['packageName'],
    appName: json['appName'],
    iconBase64: json['iconBase64'],
    isSystemApp: json['isSystemApp'] ?? false,
    isEnabled: json['isEnabled'] ?? true,
    shortcuts: List<String>.from(json['shortcuts'] ?? []),
    category: json['category'],
  );
}

class AppProvider extends ChangeNotifier {
  List<AppInfo> _apps = [];
  List<AppInfo> _hiddenApps = [];
  List<AppInfo> get apps => _apps;
  List<AppInfo> get hiddenApps => _hiddenApps;
  
  static const platform = MethodChannel('com.chumianos.launcher/system');
  
  AppProvider() {
    _loadApps();
  }

  Future<void> _loadApps() async {
    await _scanInstalledApps();
  }

  Future<void> _scanInstalledApps() async {
    try {
      final installedApps = await DeviceApps.getInstalledApplications(
        includeSystemApps: true,
        includeAppIcons: true,
        onlyAppsWithLaunchIntent: true,
      );

      final prefs = await SharedPreferences.getInstance();
      final hiddenPackages = prefs.getStringList('hidden_apps') ?? [];
      final customNames = prefs.getString('custom_app_names');
      final Map<String, String> nameMap = customNames != null 
          ? Map<String, String>.from(jsonDecode(customNames)) 
          : {};

      _apps = installedApps.where((app) {
        return !hiddenPackages.contains(app.packageName) && 
               app.packageName != 'com.chumianos.launcher' &&
               app.packageName != 'com.chumianos.setupwizard';
      }).map((app) {
        final appInfo = app as ApplicationWithIcon;
        return AppInfo(
          packageName: app.packageName,
          appName: nameMap[app.packageName] ?? app.appName,
          iconBase64: base64Encode(appInfo.icon),
          isSystemApp: app.systemApp,
          isEnabled: app.enabled,
          shortcuts: [],
        );
      }).toList();

      _apps.sort((a, b) => a.appName.compareTo(b.appName));
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading apps: $e');
    }
  }

  Future<void> launchApp(String packageName) async {
    try {
      await DeviceApps.openApp(packageName);
    } catch (e) {
      debugPrint('Error launching app: $e');
    }
  }

  Future<void> uninstallApp(String packageName) async {
    try {
      await platform.invokeMethod('uninstallApp', {'packageName': packageName});
      await _scanInstalledApps();
    } catch (e) {
      debugPrint('Error uninstalling app: $e');
    }
  }

  Future<void> hideApp(String packageName) async {
    final prefs = await SharedPreferences.getInstance();
    final hiddenPackages = prefs.getStringList('hidden_apps') ?? [];
    if (!hiddenPackages.contains(packageName)) {
      hiddenPackages.add(packageName);
      await prefs.setStringList('hidden_apps', hiddenPackages);
    }
    await _scanInstalledApps();
  }

  Future<void> showApp(String packageName) async {
    final prefs = await SharedPreferences.getInstance();
    final hiddenPackages = prefs.getStringList('hidden_apps') ?? [];
    hiddenPackages.remove(packageName);
    await prefs.setStringList('hidden_apps', hiddenPackages);
    await _scanInstalledApps();
  }

  Future<void> refreshApps() async {
    await _scanInstalledApps();
  }

  AppInfo? getAppByPackage(String packageName) {
    try {
      return _apps.firstWhere((app) => app.packageName == packageName);
    } catch (e) {
      return null;
    }
  }
}
