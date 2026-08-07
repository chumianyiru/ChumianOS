import 'package:flutter/material.dart';
import '../theme.dart';

class DeveloperOptionsScreen extends StatefulWidget {
  @override
  State<DeveloperOptionsScreen> createState() => _DeveloperOptionsScreenState();
}

class _DeveloperOptionsScreenState extends State<DeveloperOptionsScreen> {
  bool _usbDebugging = false;
  bool _stayAwake = false;
  bool _gpuRendering = false;
  bool _showTouches = false;
  bool _pointerLocation = false;
  bool _forceDarkMode = false;
  double _animationScale = 1.0;
  bool _dontKeepActivities = false;
  bool _backgroundProcesses = false;

  void _showAndroidEasterEgg() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: ChumianTheme.cardPink,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Center(child: Text('🐣 Android 彩蛋', style: TextStyle(color: ChumianTheme.textDark))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '13',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'ChumianOS 1.0',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ChumianTheme.textDark,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '基于 Android 13',
              style: TextStyle(
                color: ChumianTheme.textDark.withOpacity(0.6),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('关闭', style: TextStyle(color: ChumianTheme.primaryPink)),
          ),
        ],
      ),
    );
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
                      '开发者选项',
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
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    _SettingSection(
                      title: '调试',
                      children: [
                        SwitchListTile(
                          title: Text('USB 调试', style: TextStyle(color: ChumianTheme.textDark)),
                          subtitle: Text('通过 USB 进行调试', style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.6))),
                          value: _usbDebugging,
                          onChanged: (v) => setState(() => _usbDebugging = v),
                          activeColor: ChumianTheme.primaryPink,
                          secondary: Icon(Icons.usb, color: ChumianTheme.primaryPink),
                        ),
                        Divider(height: 1, color: ChumianTheme.lightPink.withOpacity(0.3)),
                        SwitchListTile(
                          title: Text('保持唤醒', style: TextStyle(color: ChumianTheme.textDark)),
                          subtitle: Text('充电时屏幕不休眠', style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.6))),
                          value: _stayAwake,
                          onChanged: (v) => setState(() => _stayAwake = v),
                          activeColor: ChumianTheme.primaryPink,
                          secondary: Icon(Icons.screen_lock_portrait, color: ChumianTheme.primaryPink),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _SettingSection(
                      title: '网络',
                      children: [
                        ListTile(
                          leading: Icon(Icons.wifi, color: ChumianTheme.primaryPink),
                          title: Text('WLAN 详细日志', style: TextStyle(color: ChumianTheme.textDark)),
                          trailing: Switch(value: false, onChanged: (_) {}, activeColor: ChumianTheme.primaryPink),
                          onTap: () {},
                        ),
                        Divider(height: 1, color: ChumianTheme.lightPink.withOpacity(0.3)),
                        ListTile(
                          leading: Icon(Icons.network_check, color: ChumianTheme.primaryPink),
                          title: Text('移动数据始终开启', style: TextStyle(color: ChumianTheme.textDark)),
                          trailing: Switch(value: true, onChanged: (_) {}, activeColor: ChumianTheme.primaryPink),
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _SettingSection(
                      title: '输入',
                      children: [
                        SwitchListTile(
                          title: Text('显示点按操作反馈', style: TextStyle(color: ChumianTheme.textDark)),
                          value: _showTouches,
                          onChanged: (v) => setState(() => _showTouches = v),
                          activeColor: ChumianTheme.primaryPink,
                          secondary: Icon(Icons.touch_app, color: ChumianTheme.primaryPink),
                        ),
                        Divider(height: 1, color: ChumianTheme.lightPink.withOpacity(0.3)),
                        SwitchListTile(
                          title: Text('指针位置', style: TextStyle(color: ChumianTheme.textDark)),
                          subtitle: Text('显示触摸点坐标', style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.6))),
                          value: _pointerLocation,
                          onChanged: (v) => setState(() => _pointerLocation = v),
                          activeColor: ChumianTheme.primaryPink,
                          secondary: Icon(Icons.my_location, color: ChumianTheme.primaryPink),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _SettingSection(
                      title: '绘图',
                      children: [
                        SwitchListTile(
                          title: Text('强制 GPU 渲染', style: TextStyle(color: ChumianTheme.textDark)),
                          value: _gpuRendering,
                          onChanged: (v) => setState(() => _gpuRendering = v),
                          activeColor: ChumianTheme.primaryPink,
                          secondary: Icon(Icons.games, color: ChumianTheme.primaryPink),
                        ),
                        Divider(height: 1, color: ChumianTheme.lightPink.withOpacity(0.3)),
                        SwitchListTile(
                          title: Text('强制深色模式', style: TextStyle(color: ChumianTheme.textDark)),
                          value: _forceDarkMode,
                          onChanged: (v) => setState(() => _forceDarkMode = v),
                          activeColor: ChumianTheme.primaryPink,
                          secondary: Icon(Icons.dark_mode, color: ChumianTheme.primaryPink),
                        ),
                        Divider(height: 1, color: ChumianTheme.lightPink.withOpacity(0.3)),
                        ListTile(
                          leading: Icon(Icons.animation, color: ChumianTheme.primaryPink),
                          title: Text('动画缩放', style: TextStyle(color: ChumianTheme.textDark)),
                          trailing: Text('${_animationScale}x', style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.6))),
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _SettingSection(
                      title: '应用',
                      children: [
                        SwitchListTile(
                          title: Text('不保留活动', style: TextStyle(color: ChumianTheme.textDark)),
                          subtitle: Text('离开后立即销毁活动', style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.6))),
                          value: _dontKeepActivities,
                          onChanged: (v) => setState(() => _dontKeepActivities = v),
                          activeColor: ChumianTheme.primaryPink,
                          secondary: Icon(Icons.delete_sweep, color: ChumianTheme.primaryPink),
                        ),
                        Divider(height: 1, color: ChumianTheme.lightPink.withOpacity(0.3)),
                        ListTile(
                          leading: Icon(Icons.memory, color: ChumianTheme.primaryPink),
                          title: Text('后台进程限制', style: TextStyle(color: ChumianTheme.textDark)),
                          trailing: Text('标准限制', style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.6))),
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _SettingSection(
                      title: '系统',
                      children: [
                        ListTile(
                          leading: Icon(Icons.android, color: Colors.green),
                          title: Text('安卓彩蛋', style: TextStyle(color: ChumianTheme.textDark)),
                          subtitle: Text('点击触发', style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.6))),
                          trailing: Icon(Icons.chevron_right, color: ChumianTheme.textDark.withOpacity(0.4)),
                          onTap: _showAndroidEasterEgg,
                        ),
                        Divider(height: 1, color: ChumianTheme.lightPink.withOpacity(0.3)),
                        ListTile(
                          leading: Icon(Icons.bug_report, color: ChumianTheme.primaryPink),
                          title: Text('提交错误报告', style: TextStyle(color: ChumianTheme.textDark)),
                          trailing: Icon(Icons.chevron_right, color: ChumianTheme.textDark.withOpacity(0.4)),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
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
          child: Column(children: children),
        ),
      ],
    );
  }
}
