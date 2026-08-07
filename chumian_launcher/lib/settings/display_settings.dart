import 'package:flutter/material.dart';
import '../theme.dart';

class DisplaySettingsScreen extends StatefulWidget {
  @override
  State<DisplaySettingsScreen> createState() => _DisplaySettingsScreenState();
}

class _DisplaySettingsScreenState extends State<DisplaySettingsScreen> {
  double _brightness = 0.6;
  bool _autoBrightness = true;
  bool _darkMode = false;
  double _fontSize = 1.0;
  bool _nightLight = false;
  double _screenTimeout = 2.0;

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
                      '显示与亮度',
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
                      title: '亮度',
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.brightness_low, color: ChumianTheme.primaryPink),
                                      SizedBox(width: 8),
                                      Text('亮度', style: TextStyle(color: ChumianTheme.textDark)),
                                    ],
                                  ),
                                  Text('${(_brightness * 100).toInt()}%', style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.6))),
                                ],
                              ),
                              Slider(
                                value: _brightness,
                                onChanged: (v) => setState(() => _brightness = v),
                                activeColor: ChumianTheme.primaryPink,
                                inactiveColor: ChumianTheme.lightPink.withOpacity(0.3),
                              ),
                              SwitchListTile(
                                title: Text('自动亮度调节', style: TextStyle(color: ChumianTheme.textDark)),
                                value: _autoBrightness,
                                onChanged: (v) => setState(() => _autoBrightness = v),
                                activeColor: ChumianTheme.primaryPink,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _SettingSection(
                      title: '外观',
                      children: [
                        SwitchListTile(
                          title: Text('深色模式', style: TextStyle(color: ChumianTheme.textDark)),
                          subtitle: Text('降低屏幕亮度，保护眼睛', style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.6))),
                          value: _darkMode,
                          onChanged: (v) => setState(() => _darkMode = v),
                          activeColor: ChumianTheme.primaryPink,
                          secondary: Icon(Icons.dark_mode, color: ChumianTheme.primaryPink),
                        ),
                        Divider(height: 1, color: ChumianTheme.lightPink.withOpacity(0.3)),
                        SwitchListTile(
                          title: Text('夜间护眼', style: TextStyle(color: ChumianTheme.textDark)),
                          subtitle: Text('减少蓝光，缓解疲劳', style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.6))),
                          value: _nightLight,
                          onChanged: (v) => setState(() => _nightLight = v),
                          activeColor: ChumianTheme.primaryPink,
                          secondary: Icon(Icons.nightlight_round, color: Colors.orange),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _SettingSection(
                      title: '字体与显示大小',
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('字体大小', style: TextStyle(color: ChumianTheme.textDark, fontWeight: FontWeight.w500)),
                              SizedBox(height: 12),
                              Slider(
                                value: _fontSize,
                                min: 0.8,
                                max: 1.4,
                                divisions: 3,
                                onChanged: (v) => setState(() => _fontSize = v),
                                activeColor: ChumianTheme.primaryPink,
                                inactiveColor: ChumianTheme.lightPink.withOpacity(0.3),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('小', style: TextStyle(fontSize: 12, color: ChumianTheme.textDark.withOpacity(0.6))),
                                  Text('默认', style: TextStyle(fontSize: 12, color: ChumianTheme.textDark.withOpacity(0.6))),
                                  Text('大', style: TextStyle(fontSize: 12, color: ChumianTheme.textDark.withOpacity(0.6))),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _SettingSection(
                      title: '其他',
                      children: [
                        ListTile(
                          leading: Icon(Icons.screen_lock_portrait, color: ChumianTheme.primaryPink),
                          title: Text('自动息屏', style: TextStyle(color: ChumianTheme.textDark)),
                          trailing: Text('${_screenTimeout.toInt()} 分钟', style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.6))),
                          onTap: () {},
                        ),
                        Divider(height: 1, color: ChumianTheme.lightPink.withOpacity(0.3)),
                        ListTile(
                          leading: Icon(Icons.screen_rotation, color: ChumianTheme.primaryPink),
                          title: Text('自动旋转屏幕', style: TextStyle(color: ChumianTheme.textDark)),
                          trailing: Switch(value: true, onChanged: (_) {}, activeColor: ChumianTheme.primaryPink),
                          onTap: () {},
                        ),
                        Divider(height: 1, color: ChumianTheme.lightPink.withOpacity(0.3)),
                        ListTile(
                          leading: Icon(Icons.wallpaper, color: ChumianTheme.primaryPink),
                          title: Text('壁纸设置', style: TextStyle(color: ChumianTheme.textDark)),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ],
    );
  }
}
