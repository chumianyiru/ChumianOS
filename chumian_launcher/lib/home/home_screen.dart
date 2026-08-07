import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme.dart';
import 'clock_widget.dart';
import 'app_icon.dart';
import 'widget_picker.dart';
import 'long_press_menu.dart';
import '../settings/settings_screen.dart';
import '../widgets/all_widgets.dart';

class ChumianHomeScreen extends StatefulWidget {
  @override
  State<ChumianHomeScreen> createState() => _ChumianHomeScreenState();
}

class _ChumianHomeScreenState extends State<ChumianHomeScreen> {
  bool _isEditMode = false;
  int _currentTheme = 0;
  List<Widget> _desktopWidgets = [];
  final List<Map<String, dynamic>> _apps = [
    {'name': '设置', 'icon': Icons.settings, 'color': Color(0xFFF48FB1)},
    {'name': '电话', 'icon': Icons.phone, 'color': Color(0xFF81C784)},
    {'name': '信息', 'icon': Icons.message, 'color': Color(0xFF64B5F6)},
    {'name': '相机', 'icon': Icons.camera_alt, 'color': Color(0xFFBA68C8)},
    {'name': '相册', 'icon': Icons.photo, 'color': Color(0xFFFFB74D)},
    {'name': '音乐', 'icon': Icons.music_note, 'color': Color(0xFFE57373)},
    {'name': '浏览器', 'icon': Icons.public, 'color': Color(0xFF4FC3F7)},
    {'name': '邮件', 'icon': Icons.email, 'color': Color(0xFFA1887F)},
    {'name': '日历', 'icon': Icons.calendar_today, 'color': Color(0xFF7986CB)},
    {'name': '时钟', 'icon': Icons.access_time, 'color': Color(0xFF4DB6AC)},
    {'name': '天气', 'icon': Icons.wb_sunny, 'color': Color(0xFFFFD54F)},
    {'name': '地图', 'icon': Icons.map, 'color': Color(0xFF8D6E63)},
    {'name': '应用商店', 'icon': Icons.store, 'color': Color(0xFF9575CD)},
    {'name': '计算器', 'icon': Icons.calculate, 'color': Color(0xFF78909C)},
    {'name': '备忘录', 'icon': Icons.note, 'color': Color(0xFFFFF176)},
    {'name': '文件管理', 'icon': Icons.folder, 'color': Color(0xFF90A4AE)},
    {'name': '录音机', 'icon': Icons.mic, 'color': Color(0xFFEF5350)},
    {'name': '视频', 'icon': Icons.play_circle_filled, 'color': Color(0xFFEC407A)},
    {'name': '游戏中心', 'icon': Icons.sports_esports, 'color': Color(0xFF26A69A)},
    {'name': '健康', 'icon': Icons.favorite, 'color': Color(0xFFEF9A9A)},
  ];

  final List<Color> _themes = [
    ChumianTheme.primaryPink,
    Color(0xFFCE93D8),
    Color(0xFF90CAF9),
    Color(0xFFA5D6A7),
    Color(0xFFFFCC80),
    Color(0xFFF48FB1),
    Color(0xFFB39DDB),
    Color(0xFF80DEEA),
    Color(0xFFC5E1A5),
    Color(0xFFFFAB91),
  ];

  @override
  void initState() {
    super.initState();
    _desktopWidgets = [
      ClockWidgetCard(),
      WeatherWidgetCard(),
      MusicWidgetCard(),
    ];
  }

  void _toggleTheme() {
    setState(() {
      _currentTheme = (_currentTheme + 1) % _themes.length;
    });
  }

  void _enterEditMode() {
    setState(() {
      _isEditMode = true;
    });
    HapticFeedback.mediumImpact();
  }

  void _exitEditMode() {
    setState(() {
      _isEditMode = false;
    });
  }

  void _showWidgetPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => WidgetPickerSheet(
        onWidgetSelected: (widget) {
          setState(() {
            _desktopWidgets.add(widget);
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _showAppLongPressMenu(int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => LongPressMenuSheet(
        appName: _apps[index]['name'],
        onDelete: () {
          setState(() {
            _apps.removeAt(index);
          });
          Navigator.pop(context);
        },
        onInfo: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('应用信息')),
          );
        },
        onShortcut: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('快捷指令')),
          );
        },
      ),
    );
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = _themes[_currentTheme];
    return Scaffold(
      body: GestureDetector(
        onLongPress: _enterEditMode,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                themeColor.withOpacity(0.3),
                themeColor.withOpacity(0.1),
              ],
            ),
          ),
          child: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  top: 8,
                  left: 16,
                  child: Text(
                    'chumian',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: themeColor,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 16,
                  child: GestureDetector(
                    onTap: _toggleTheme,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: themeColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.palette, size: 16, color: themeColor),
                          SizedBox(width: 4),
                          Text(
                            '主题',
                            style: TextStyle(
                              fontSize: 12,
                              color: themeColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: 60),
                    Center(child: ClockWidget()),
                    SizedBox(height: 20),
                    ..._desktopWidgets.map((w) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: w,
                    )),
                    SizedBox(height: 20),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.8,
                          ),
                          itemCount: _apps.length,
                          itemBuilder: (context, index) {
                            final app = _apps[index];
                            return AppIcon(
                              appName: app['name'],
                              icon: app['icon'],
                              bgColor: _isEditMode
                                  ? app['color'].withOpacity(0.6)
                                  : app['color'],
                              onTap: () {
                                if (_isEditMode) return;
                                if (app['name'] == '设置') {
                                  _openSettings();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('打开 ${app['name']}'),
                                      duration: Duration(seconds: 1),
                                    ),
                                  );
                                }
                              },
                              onLongPress: () => _showAppLongPressMenu(index),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                  ],
                ),
                if (_isEditMode)
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _EditModeButton(
                          icon: Icons.widgets,
                          label: '添加小组件',
                          color: themeColor,
                          onTap: _showWidgetPicker,
                        ),
                        _EditModeButton(
                          icon: Icons.settings,
                          label: '启动器设置',
                          color: themeColor,
                          onTap: _openSettings,
                        ),
                        _EditModeButton(
                          icon: Icons.done,
                          label: '完成',
                          color: themeColor,
                          onTap: _exitEditMode,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EditModeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _EditModeButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: ChumianTheme.softShadow,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: ChumianTheme.textDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
