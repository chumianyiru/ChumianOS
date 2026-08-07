import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class DisplayScreen extends StatefulWidget {
  const DisplayScreen({super.key});

  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  double _brightness = 0.7;
  bool _autoBrightness = true;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('显示'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard([
            ListTile(
              leading: const Icon(Icons.brightness_6),
              title: const Text('亮度'),
              subtitle: Slider(
                value: _brightness,
                onChanged: (v) {
                  setState(() => _brightness = v);
                  context.read<SettingsProvider>().setBrightness(v);
                },
              ),
            ),
            SwitchListTile(
              secondary: const Icon(Icons.brightness_auto),
              title: const Text('自动亮度'),
              value: _autoBrightness,
              onChanged: (v) => setState(() => _autoBrightness = v),
            ),
          ]),
          const SizedBox(height: 16),
          _buildCard([
            SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text('深色模式'),
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
            ),
            const ListTile(
              leading: Icon(Icons.font_download),
              title: Text('字体大小'),
              subtitle: Text('默认'),
              trailing: Icon(Icons.chevron_right),
            ),
            const ListTile(
              leading: Icon(Icons.aspect_ratio),
              title: Text('屏幕分辨率'),
              subtitle: Text('1080 x 2400'),
              trailing: Icon(Icons.chevron_right),
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
