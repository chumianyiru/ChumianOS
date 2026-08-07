import 'package:flutter/material.dart';

class BatteryScreen extends StatelessWidget {
  const BatteryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('电池'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                const Icon(Icons.battery_full, size: 64, color: Colors.green),
                const SizedBox(height: 12),
                const Text('85%', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('预计剩余 8 小时 30 分钟', style: TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.outline)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCard([
            const ListTile(
              leading: Icon(Icons.battery_saver),
              title: Text('省电模式'),
              trailing: Switch(value: false, onChanged: null),
            ),
            const ListTile(
              leading: Icon(Icons.battery_unknown),
              title: Text('电池健康'),
              subtitle: Text('良好'),
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
