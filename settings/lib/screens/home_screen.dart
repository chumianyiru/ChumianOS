import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(context, '网络与连接', [
            _settingItem(context, Icons.wifi, 'WLAN', '/network', subtitle: '已连接'),
            _settingItem(context, Icons.bluetooth, '蓝牙', '/network', subtitle: '已开启'),
            _settingItem(context, Icons.sim_card, '移动网络', '/network'),
          ]),
          const SizedBox(height: 16),
          _buildSection(context, '个性化', [
            _settingItem(context, Icons.brightness_6, '显示', '/display'),
            _settingItem(context, Icons.volume_up, '声音与振动', '/sound'),
            _settingItem(context, Icons.wallpaper, '壁纸', '/display'),
          ]),
          const SizedBox(height: 16),
          _buildSection(context, '系统', [
            _settingItem(context, Icons.apps, '应用管理', '/apps'),
            _settingItem(context, Icons.battery_full, '电池', '/battery'),
            _settingItem(context, Icons.storage, '存储', '/storage'),
            _settingItem(context, Icons.security, '安全', '/security'),
            _settingItem(context, Icons.folder, '文件管理', '/files'),
          ]),
          const SizedBox(height: 16),
          _buildSection(context, '关于', [
            _settingItem(context, Icons.info_outline, '关于手机', '/about', subtitle: 'ChumianOS 1.0'),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _settingItem(BuildContext context, IconData icon, String title, String route, {String? subtitle}) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
      ),
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(fontSize: 12)) : null,
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: () => Navigator.pushNamed(context, route),
    );
  }
}
