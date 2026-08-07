import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme.dart';
import 'about_screen.dart';
import 'developer_options.dart';
import 'display_settings.dart';
import 'sound_settings.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _developerMode = false;
  int _devClickCount = 0;

  final List<Map<String, dynamic>> _settingsGroups = [
    {
      'title': '网络与连接',
      'items': [
        {'icon': Icons.wifi, 'title': 'WLAN', 'subtitle': 'Chumian_5G', 'color': Colors.blue},
        {'icon': Icons.bluetooth, 'title': '蓝牙', 'subtitle': '已开启', 'color': Colors.blue},
        {'icon': Icons.signal_cellular_alt, 'title': '移动网络', 'subtitle': '4G', 'color': Colors.green},
        {'icon': Icons.wifi_tethering, 'title': '热点与共享', 'subtitle': '', 'color': Colors.orange},
        {'icon': Icons.nfc, 'title': 'NFC', 'subtitle': '已开启', 'color': Colors.indigo},
      ],
    },
    {
      'title': '个性化',
      'items': [
        {'icon': Icons.palette, 'title': '显示与亮度', 'subtitle': '粉色主题', 'color': ChumianTheme.primaryPink, 'route': 'display'},
        {'icon': Icons.music_note, 'title': '声音与振动', 'subtitle': '', 'color': Colors.purple, 'route': 'sound'},
        {'icon': Icons.wallpaper, 'title': '壁纸', 'subtitle': '粉色渐变', 'color': Colors.pink},
        {'icon': Icons.style, 'title': '图标主题', 'subtitle': '默认圆形', 'color': Colors.teal},
        {'icon': Icons.widgets, 'title': '小组件管理', 'subtitle': '已添加 3 个', 'color': Colors.cyan},
      ],
    },
    {
      'title': '应用与权限',
      'items': [
        {'icon': Icons.apps, 'title': '应用管理', 'subtitle': '共 42 个应用', 'color': Colors.orange},
        {'icon': Icons.security, 'title': '权限管理', 'subtitle': '', 'color': Colors.red},
        {'icon': Icons.notifications, 'title': '通知管理', 'subtitle': '', 'color': Colors.pink},
        {'icon': Icons.default_icon_sharp, 'title': '默认应用', 'subtitle': '', 'color': Colors.blueGrey},
      ],
    },
    {
      'title': '系统与设备',
      'items': [
        {'icon': Icons.security, 'title': '安全与隐私', 'subtitle': '', 'color': Colors.red},
        {'icon': Icons.location_on, 'title': '位置信息', 'subtitle': '已开启', 'color': Colors.green},
        {'icon': Icons.accessibility, 'title': '无障碍', 'subtitle': '', 'color': Colors.orange},
        {'icon': Icons.backup, 'title': '备份与恢复', 'subtitle': '', 'color': Colors.blue},
        {'icon': Icons.update, 'title': '系统更新', 'subtitle': '已是最新版本', 'color': Colors.teal},
      ],
    },
    {
      'title': '关于',
      'items': [
        {'icon': Icons.info_outline, 'title': '关于手机', 'subtitle': 'ChumianOS 1.0', 'color': ChumianTheme.primaryPink, 'route': 'about'},
      ],
    },
  ];

  void _onItemTap(Map<String, dynamic> item) {
    final route = item['route'];
    if (route == 'about') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AboutScreen(
          onDevClick: _handleDevClick,
          developerMode: _developerMode,
        )),
      ).then((_) {
        if (_developerMode) {
          setState(() {});
        }
      });
    } else if (route == 'display') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DisplaySettingsScreen()),
      );
    } else if (route == 'sound') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SoundSettingsScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${item['title']} 设置')),
      );
    }
  }

  void _handleDevClick() {
    setState(() {
      _devClickCount++;
      if (_devClickCount >= 7 && !_developerMode) {
        _developerMode = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('开发者模式已开启！')),
        );
        if (_settingsGroups.last['title'] != '开发者选项') {
          _settingsGroups.add({
            'title': '开发者选项',
            'items': [
              {'icon': Icons.code, 'title': '开发者选项', 'subtitle': '已开启', 'color': Colors.orange, 'route': 'dev'},
              {'icon': Icons.android, 'title': '安卓彩蛋', 'subtitle': '点击触发', 'color': Colors.green, 'route': 'egg'},
            ],
          });
        }
      } else if (_devClickCount < 7) {
        final remaining = 7 - _devClickCount;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('再点击 $remaining 次开启开发者模式')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ChumianTheme.pinkGradientBox,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_back, color: ChumianTheme.textDark),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      '设置',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ChumianTheme.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _settingsGroups.length,
                  itemBuilder: (context, groupIndex) {
                    final group = _settingsGroups[groupIndex];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (groupIndex > 0) SizedBox(height: 8),
                        Padding(
                          padding: EdgeInsets.only(left: 16, bottom: 8, top: 16),
                          child: Text(
                            group['title'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ChumianTheme.textDark.withOpacity(0.6),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              for (int i = 0; i < group['items'].length; i++) ...[
                                _SettingsTile(
                                  icon: group['items'][i]['icon'],
                                  title: group['items'][i]['title'],
                                  subtitle: group['items'][i]['subtitle'],
                                  color: group['items'][i]['color'],
                                  onTap: () => _onItemTap(group['items'][i]),
                                ),
                                if (i < group['items'].length - 1)
                                  Padding(
                                    padding: EdgeInsets.only(left: 72),
                                    child: Divider(height: 1, color: ChumianTheme.lightPink.withOpacity(0.3)),
                                  ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: ChumianTheme.textDark,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: subtitle.isNotEmpty
          ? Text(
              subtitle,
              style: TextStyle(
                color: ChumianTheme.textDark.withOpacity(0.6),
                fontSize: 13,
              ),
            )
          : null,
      trailing: Icon(Icons.chevron_right, color: ChumianTheme.textDark.withOpacity(0.4)),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
