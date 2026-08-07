import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  int _tapCount = 0;

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('关于手机'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.shade300, Colors.pink.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Column(
              children: [
                Icon(Icons.android, size: 64, color: Colors.white),
                SizedBox(height: 16),
                Text('ChumianOS', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                SizedBox(height: 8),
                Text('Version 1.0.0', style: TextStyle(fontSize: 14, color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCard([
            GestureDetector(
              onTap: () {
                _tapCount++;
                if (_tapCount >= 7) {
                  context.read<SettingsProvider>().toggleDeveloperMode();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(settings.developerMode ? '开发者模式已关闭' : '开发者模式已开启！'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  );
                  _tapCount = 0;
                }
              },
              child: const ListTile(
                leading: Icon(Icons.info_outline),
                title: Text('版本号'),
                subtitle: Text('ChumianOS 1.0.0 (Android 14)'),
                trailing: Icon(Icons.chevron_right),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.developer_board),
              title: Text('型号'),
              subtitle: Text('ChumianOS Device'),
            ),
            const ListTile(
              leading: Icon(Icons.memory),
              title: Text('处理器'),
              subtitle: Text('Octa-core 2.8GHz'),
            ),
            const ListTile(
              leading: Icon(Icons.sd_storage),
              title: Text('运行内存'),
              subtitle: Text('12 GB'),
            ),
          ]),
          const SizedBox(height: 16),
          if (settings.developerMode)
            _buildCard([
              ListTile(
                leading: const Icon(Icons.developer_mode, color: Colors.orange),
                title: const Text('开发者选项'),
                subtitle: const Text('已开启'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.android),
                title: const Text('Android 彩蛋'),
                onTap: () => context.read<SettingsProvider>().showEasterEgg(),
              ),
            ]),
          const SizedBox(height: 16),
          _buildCard([
            ListTile(
              leading: const Icon(Icons.restart_alt, color: Colors.orange),
              title: const Text('重启'),
              onTap: () => context.read<SettingsProvider>().reboot(),
            ),
            ListTile(
              leading: const Icon(Icons.power_settings_new, color: Colors.red),
              title: const Text('关机'),
              onTap: () => context.read<SettingsProvider>().shutdown(),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(children: children),
    );
  }
}
