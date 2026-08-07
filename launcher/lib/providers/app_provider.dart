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

  AppInfo({
    required this.packageName,
    required this.appName,
    this.iconBase64,
    this.isSystemApp = false,
    this.isEnabled = true,
    this.shortcuts = const [],
  });

  Map<String, dynamic> toJson() => {
    'packageName': packageName,
    'appName': appName,
    'iconBase64': iconBase64,
    'isSystemApp': isSystemApp,
    'isEnabled': isEnabled,
    'shortcuts': shortcuts,
  };

  factory AppInfo.fromJson(Map<String, dynamic> json) => AppInfo(
    packageName: json['packageName'],
    appName: json['appName'],
    iconBase64: json['iconBase64'],
    isSystemApp: json['isSystemApp'] ?? false,
    isEnabled: json['isEnabled'] ?? true,
    shortcuts: List<String>.from(json['shortcuts'] ?? []),
  );
}

class AppProvider extends ChangeNotifier {
  List<AppInfo> _apps = [];
  List<AppInfo> _hiddenApps = [];
  bool _isLoading = true;

  List<AppInfo> get apps => _apps;
  List<AppInfo> get hiddenApps => _hiddenApps;
  bool get isLoading => _isLoading;

  static const platform = MethodChannel('com.chumianos.launcher/system');

  AppProvider() {
    _loadApps();
  }

  Future<void> _loadApps() async {
    _isLoading = true;
    notifyListeners();
    await _scanInstalledApps();
    _isLoading = false;
    notifyListeners();
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
      
      final hiddenPackagesSet = {...hiddenPackages, 'com.android.settings'};

      _apps = installedApps.where((app) {
        return !hiddenPackagesSet.contains(app.packageName) &&
               app.packageName != 'com.chumianos.launcher' &&
               app.packageName != 'com.chumianos.setupwizard';
      }).map((app) {
        final appInfo = app as ApplicationWithIcon;
        return AppInfo(
          packageName: app.packageName,
          appName: app.appName,
          iconBase64: base64Encode(appInfo.icon),
          isSystemApp: app.systemApp,
          isEnabled: app.enabled,
          shortcuts: _getShortcuts(app.packageName),
        );
      }).toList();

      _apps.sort((a, b) => a.appName.compareTo(b.appName));

      _hiddenApps = installedApps.where((app) {
        return hiddenPackagesSet.contains(app.packageName);
      }).map((app) {
        final appInfo = app as ApplicationWithIcon;
        return AppInfo(
          packageName: app.packageName,
          appName: app.appName,
          iconBase64: base64Encode(appInfo.icon),
          isSystemApp: app.systemApp,
          isEnabled: app.enabled,
        );
      }).toList();
    } catch (e) {
      debugPrint('Error loading apps: $e');
    }
  }

  List<String> _getShortcuts(String packageName) {
    final shortcuts = <String>[];
    if (packageName.contains('phone') || packageName.contains('dialer')) {
      shortcuts.addAll(['快速拨号', '最近通话', '收藏联系人']);
    } else if (packageName.contains('camera')) {
      shortcuts.addAll(['拍照', '录像', '自拍']);
    } else if (packageName.contains('message') || packageName.contains('sms')) {
      shortcuts.addAll(['新建短信', '最近消息']);
    } else if (packageName.contains('browser') || packageName.contains('chrome')) {
      shortcuts.addAll(['新建标签页', '无痕模式', '历史记录']);
    }
    return shortcuts;
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
      notifyListeners();
    } catch (e) {
      debugPrint('Error uninstalling app: $e');
    }
  }

  Future<void> openAppInfo(String packageName) async {
    try {
      await platform.invokeMethod('openAppInfo', {'packageName': packageName});
    } catch (e) {
      debugPrint('Error opening app info: $e');
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
    notifyListeners();
  }

  Future<void> showApp(String packageName) async {
    final prefs = await SharedPreferences.getInstance();
    final hiddenPackages = prefs.getStringList('hidden_apps') ?? [];
    hiddenPackages.remove(packageName);
    await prefs.setStringList('hidden_apps', hiddenPackages);
    await _scanInstalledApps();
    notifyListeners();
  }

  Future<void> refreshApps() async {
    await _scanInstalledApps();
    notifyListeners();
  }

  AppInfo? getAppByPackage(String packageName) {
    try {
      return _apps.firstWhere((app) => app.packageName == packageName);
    } catch (e) {
      return null;
    }
  }
}
