import 'package:flutter/material.dart';
import '../theme.dart';

class SoundSettingsScreen extends StatefulWidget {
  @override
  State<SoundSettingsScreen> createState() => _SoundSettingsScreenState();
}

class _SoundSettingsScreenState extends State<SoundSettingsScreen> {
  double _mediaVolume = 0.7;
  double _ringVolume = 0.8;
  double _alarmVolume = 0.6;
  bool _vibrate = true;
  bool _doNotDisturb = false;
  bool _touchSound = true;

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
                      '声音与振动',
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
                    _VolumeSection(
                      icon: Icons.music_note,
                      title: '媒体音量',
                      value: _mediaVolume,
                      color: ChumianTheme.primaryPink,
                      onChanged: (v) => setState(() => _mediaVolume = v),
                    ),
                    SizedBox(height: 16),
                    _VolumeSection(
                      icon: Icons.ring_volume,
                      title: '铃声音量',
                      value: _ringVolume,
                      color: Colors.blue,
                      onChanged: (v) => setState(() => _ringVolume = v),
                    ),
                    SizedBox(height: 16),
                    _VolumeSection(
                      icon: Icons.alarm,
                      title: '闹钟音量',
                      value: _alarmVolume,
                      color: Colors.orange,
                      onChanged: (v) => setState(() => _alarmVolume = v),
                    ),
                    SizedBox(height: 24),
                    _SettingSection(
                      title: '振动',
                      children: [
                        SwitchListTile(
                          title: Text('振动反馈', style: TextStyle(color: ChumianTheme.textDark)),
                          subtitle: Text('触摸时振动', style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.6))),
                          value: _vibrate,
                          onChanged: (v) => setState(() => _vibrate = v),
                          activeColor: ChumianTheme.primaryPink,
                          secondary: Icon(Icons.vibration, color: ChumianTheme.primaryPink),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _SettingSection(
                      title: '勿扰模式',
                      children: [
                        SwitchListTile(
                          title: Text('勿扰模式', style: TextStyle(color: ChumianTheme.textDark)),
                          subtitle: Text('静音通知和来电', style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.6))),
                          value: _doNotDisturb,
                          onChanged: (v) => setState(() => _doNotDisturb = v),
                          activeColor: ChumianTheme.primaryPink,
                          secondary: Icon(Icons.do_not_disturb_on, color: Colors.purple),
                        ),
                        Divider(height: 1, color: ChumianTheme.lightPink.withOpacity(0.3)),
                        ListTile(
                          leading: Icon(Icons.schedule, color: ChumianTheme.primaryPink),
                          title: Text('定时开启', style: TextStyle(color: ChumianTheme.textDark)),
                          trailing: Icon(Icons.chevron_right, color: ChumianTheme.textDark.withOpacity(0.4)),
                          onTap: () {},
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _SettingSection(
                      title: '其他声音',
                      children: [
                        SwitchListTile(
                          title: Text('触摸提示音', style: TextStyle(color: ChumianTheme.textDark)),
                          value: _touchSound,
                          onChanged: (v) => setState(() => _touchSound = v),
                          activeColor: ChumianTheme.primaryPink,
                          secondary: Icon(Icons.touch_app, color: ChumianTheme.primaryPink),
                        ),
                        Divider(height: 1, color: ChumianTheme.lightPink.withOpacity(0.3)),
                        ListTile(
                          leading: Icon(Icons.lock, color: ChumianTheme.primaryPink),
                          title: Text('锁屏提示音', style: TextStyle(color: ChumianTheme.textDark)),
                          trailing: Switch(value: true, onChanged: (_) {}, activeColor: ChumianTheme.primaryPink),
                          onTap: () {},
                        ),
                        Divider(height: 1, color: ChumianTheme.lightPink.withOpacity(0.3)),
                        ListTile(
                          leading: Icon(Icons.keyboard, color: ChumianTheme.primaryPink),
                          title: Text('按键音', style: TextStyle(color: ChumianTheme.textDark)),
                          trailing: Switch(value: false, onChanged: (_) {}, activeColor: ChumianTheme.primaryPink),
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

class _VolumeSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final double value;
  final Color color;
  final ValueChanged<double> onChanged;

  const _VolumeSection({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ChumianTheme.textDark,
                ),
              ),
              Spacer(),
              Text(
                '${(value * 100).toInt()}%',
                style: TextStyle(
                  color: ChumianTheme.textDark.withOpacity(0.6),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Slider(
            value: value,
            onChanged: onChanged,
            activeColor: color,
            inactiveColor: color.withOpacity(0.2),
          ),
        ],
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
