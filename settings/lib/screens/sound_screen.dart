import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';

class SoundScreen extends StatefulWidget {
  const SoundScreen({super.key});

  @override
  State<SoundScreen> createState() => _SoundScreenState();
}

class _SoundScreenState extends State<SoundScreen> {
  double _mediaVolume = 0.6;
  double _ringVolume = 0.8;
  bool _vibrate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('声音与振动'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard([
            ListTile(
              leading: const Icon(Icons.music_note),
              title: const Text('媒体音量'),
              subtitle: Slider(
                value: _mediaVolume,
                onChanged: (v) {
                  setState(() => _mediaVolume = v);
                  context.read<SettingsProvider>().setVolume(v);
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('铃声音量'),
              subtitle: Slider(
                value: _ringVolume,
                onChanged: (v) => setState(() => _ringVolume = v),
              ),
            ),
            SwitchListTile(
              secondary: const Icon(Icons.vibration),
              title: const Text('振动反馈'),
              value: _vibrate,
              onChanged: (v) => setState(() => _vibrate = v),
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
