import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DesktopWidget {
  final String id;
  final String type;
  final int x, y, width, height;
  final Map<String, dynamic> config;

  DesktopWidget({
    required this.id,
    required this.type,
    this.x = 0,
    this.y = 0,
    this.width = 2,
    this.height = 2,
    this.config = const {},
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'x': x, 'y': y,
    'width': width, 'height': height,
    'config': config,
  };

  factory DesktopWidget.fromJson(Map<String, dynamic> json) => DesktopWidget(
    id: json['id'],
    type: json['type'],
    x: json['x'] ?? 0,
    y: json['y'] ?? 0,
    width: json['width'] ?? 2,
    height: json['height'] ?? 2,
    config: Map<String, dynamic>.from(json['config'] ?? {}),
  );

  DesktopWidget copyWith({
    String? id,
    String? type,
    int? x,
    int? y,
    int? width,
    int? height,
    Map<String, dynamic>? config,
  }) {
    return DesktopWidget(
      id: id ?? this.id,
      type: type ?? this.type,
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      config: config ?? this.config,
    );
  }
}

class WidgetProvider extends ChangeNotifier {
  List<DesktopWidget> _widgets = [];
  List<DesktopWidget> get widgets => _widgets;

  final List<Map<String, dynamic>> availableWidgets = [
    {'type': 'clock_analog', 'name': '模拟时钟', 'icon': Icons.access_time, 'w': 2, 'h': 2, 'category': '时间'},
    {'type': 'clock_digital', 'name': '数字时钟', 'icon': Icons.timer, 'w': 2, 'h': 1, 'category': '时间'},
    {'type': 'clock_flip', 'name': '翻页时钟', 'icon': Icons.flip_to_front, 'w': 2, 'h': 1, 'category': '时间'},
    {'type': 'clock_world', 'name': '世界时钟', 'icon': Icons.public, 'w': 2, 'h': 1, 'category': '时间'},
    {'type': 'date_display', 'name': '日期显示', 'icon': Icons.calendar_today, 'w': 2, 'h': 1, 'category': '时间'},
    {'type': 'weather', 'name': '天气', 'icon': Icons.wb_sunny, 'w': 2, 'h': 2, 'category': '生活'},
    {'type': 'weather_mini', 'name': '迷你天气', 'icon': Icons.cloud, 'w': 1, 'h': 1, 'category': '生活'},
    {'type': 'calendar_month', 'name': '月历', 'icon': Icons.calendar_month, 'w': 2, 'h': 2, 'category': '时间'},
    {'type': 'battery', 'name': '电池', 'icon': Icons.battery_full, 'w': 1, 'h': 1, 'category': '系统'},
    {'type': 'battery_circle', 'name': '环形电池', 'icon': Icons.battery_charging_full, 'w': 1, 'h': 1, 'category': '系统'},
    {'type': 'music', 'name': '音乐播放器', 'icon': Icons.music_note, 'w': 2, 'h': 1, 'category': '娱乐'},
    {'type': 'search', 'name': '搜索栏', 'icon': Icons.search, 'w': 4, 'h': 1, 'category': '工具'},
    {'type': 'notes', 'name': '便签', 'icon': Icons.sticky_note_2, 'w': 2, 'h': 2, 'category': '工具'},
    {'type': 'photos', 'name': '照片相框', 'icon': Icons.photo, 'w': 2, 'h': 2, 'category': '娱乐'},
    {'type': 'cpu', 'name': 'CPU监控', 'icon': Icons.memory, 'w': 1, 'h': 1, 'category': '系统'},
    {'type': 'memory', 'name': '内存监控', 'icon': Icons.storage, 'w': 1, 'h': 1, 'category': '系统'},
    {'type': 'network', 'name': '网络状态', 'icon': Icons.network_check, 'w': 1, 'h': 1, 'category': '系统'},
    {'type': 'storage', 'name': '存储使用', 'icon': Icons.sd_storage, 'w': 1, 'h': 1, 'category': '系统'},
    {'type': 'steps', 'name': '步数统计', 'icon': Icons.directions_walk, 'w': 1, 'h': 1, 'category': '健康'},
    {'type': 'heart_rate', 'name': '心率', 'icon': Icons.favorite, 'w': 1, 'h': 1, 'category': '健康'},
    {'type': 'timer', 'name': '计时器', 'icon': Icons.hourglass_empty, 'w': 1, 'h': 1, 'category': '工具'},
    {'type': 'alarm', 'name': '闹钟', 'icon': Icons.alarm, 'w': 1, 'h': 1, 'category': '时间'},
    {'type': 'moon_phase', 'name': '月相', 'icon': Icons.nightlight_round, 'w': 1, 'h': 1, 'category': '生活'},
    {'type': 'sunrise', 'name': '日出日落', 'icon': Icons.wb_twilight, 'w': 2, 'h': 1, 'category': '生活'},
    {'type': 'todo', 'name': '待办事项', 'icon': Icons.check_circle_outline, 'w': 2, 'h': 2, 'category': '工具'},
    {'type': 'flashlight', 'name': '手电筒', 'icon': Icons.flashlight_on, 'w': 1, 'h': 1, 'category': '快捷'},
    {'type': 'calculator', 'name': '计算器', 'icon': Icons.calculate, 'w': 2, 'h': 2, 'category': '工具'},
    {'type': 'compass', 'name': '指南针', 'icon': Icons.explore, 'w': 2, 'h': 2, 'category': '工具'},
    {'type': 'sound', 'name': '音量控制', 'icon': Icons.volume_up, 'w': 2, 'h': 1, 'category': '快捷'},
    {'type': 'brightness', 'name': '亮度调节', 'icon': Icons.brightness_6, 'w': 2, 'h': 1, 'category': '快捷'},
    {'type': 'wifi_toggle', 'name': 'WiFi开关', 'icon': Icons.wifi, 'w': 1, 'h': 1, 'category': '快捷'},
    {'type': 'bluetooth_toggle', 'name': '蓝牙开关', 'icon': Icons.bluetooth, 'w': 1, 'h': 1, 'category': '快捷'},
    {'type': 'airplane_toggle', 'name': '飞行模式', 'icon': Icons.airplanemode_active, 'w': 1, 'h': 1, 'category': '快捷'},
    {'type': 'rotation_toggle', 'name': '旋转锁定', 'icon': Icons.screen_rotation, 'w': 1, 'h': 1, 'category': '快捷'},
    {'type': 'system_info', 'name': '系统信息', 'icon': Icons.computer, 'w': 2, 'h': 2, 'category': '系统'},
    {'type': 'app_shortcuts', 'name': '应用快捷方式', 'icon': Icons.apps, 'w': 2, 'h': 1, 'category': '快捷'},
  ];

  WidgetProvider() {
    _loadWidgets();
  }

  Future<void> _loadWidgets() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('desktop_widgets');
    if (data != null && data.isNotEmpty) {
      try {
        final list = jsonDecode(data) as List;
        _widgets = list.map((e) => DesktopWidget.fromJson(e)).toList();
        notifyListeners();
      } catch (e) {
        _initDefaultWidgets();
      }
    } else {
      _initDefaultWidgets();
    }
  }

  void _initDefaultWidgets() {
    _widgets = [
      DesktopWidget(
        id: const Uuid().v4(),
        type: 'clock_digital',
        x: 1, y: 0,
        width: 2, height: 1,
      ),
    ];
    _saveWidgets();
    notifyListeners();
  }

  Future<void> _saveWidgets() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('desktop_widgets', jsonEncode(_widgets.map((e) => e.toJson()).toList()));
  }

  void addWidget(String type, {int x = 0, int y = 0}) {
    final template = availableWidgets.firstWhere(
      (w) => w['type'] == type,
      orElse: () => availableWidgets.first,
    );
    _widgets.add(DesktopWidget(
      id: const Uuid().v4(),
      type: type,
      x: x,
      y: y,
      width: template['w'] as int,
      height: template['h'] as int,
    ));
    _saveWidgets();
    notifyListeners();
  }

  void removeWidget(String id) {
    _widgets.removeWhere((w) => w.id == id);
    _saveWidgets();
    notifyListeners();
  }

  void updateWidget(String id, DesktopWidget newWidget) {
    final index = _widgets.indexWhere((w) => w.id == id);
    if (index != -1) {
      _widgets[index] = newWidget;
      _saveWidgets();
      notifyListeners();
    }
  }

  void moveWidget(String id, int newX, int newY) {
    final index = _widgets.indexWhere((w) => w.id == id);
    if (index != -1) {
      _widgets[index] = _widgets[index].copyWith(x: newX, y: newY);
      _saveWidgets();
      notifyListeners();
    }
  }

  void resetWidgets() {
    _initDefaultWidgets();
  }
}
