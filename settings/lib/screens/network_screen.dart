import 'package:flutter/material.dart';

class NetworkScreen extends StatelessWidget {
  const NetworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('网络与连接'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard([
            SwitchListTile(
              secondary: const Icon(Icons.wifi),
              title: const Text('WLAN'),
              subtitle: const Text('已连接 Chumian-5G'),
              value: true,
              onChanged: (_) {},
            ),
            SwitchListTile(
              secondary: const Icon(Icons.bluetooth),
              title: const Text('蓝牙'),
              value: true,
              onChanged: (_) {},
            ),
            SwitchListTile(
              secondary: const Icon(Icons.signal_cellular_alt),
              title: const Text('移动数据'),
              value: false,
              onChanged: (_) {},
            ),
          ]),
          const SizedBox(height: 16),
          _buildCard([
            const ListTile(
              leading: Icon(Icons.airplanemode_active),
              title: Text('飞行模式'),
              trailing: Switch(value: false, onChanged: null),
            ),
            const ListTile(
              leading: Icon(Icons.vpn_key),
              title: Text('VPN'),
              subtitle: Text('未连接'),
              trailing: Icon(Icons.chevron_right),
            ),
            const ListTile(
              leading: Icon(Icons.nfc),
              title: Text('NFC'),
              trailing: Switch(value: false, onChanged: null),
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
