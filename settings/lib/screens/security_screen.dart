import 'package:flutter/material.dart';

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('安全'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard([
            const ListTile(
              leading: Icon(Icons.fingerprint),
              title: Text('指纹解锁'),
              subtitle: Text('已设置 2 个指纹'),
              trailing: Icon(Icons.chevron_right),
            ),
            const ListTile(
              leading: Icon(Icons.lock),
              title: Text('锁屏密码'),
              subtitle: Text('已设置'),
              trailing: Icon(Icons.chevron_right),
            ),
            const ListTile(
              leading: Icon(Icons.face),
              title: Text('面部识别'),
              subtitle: Text('未设置'),
              trailing: Icon(Icons.chevron_right),
            ),
          ]),
          const SizedBox(height: 16),
          _buildCard([
            const ListTile(
              leading: Icon(Icons.shield),
              title: Text('应用锁'),
              subtitle: Text('保护隐私应用'),
              trailing: Icon(Icons.chevron_right),
            ),
            const ListTile(
              leading: Icon(Icons.vpn_lock),
              title: Text('隐私保护'),
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
