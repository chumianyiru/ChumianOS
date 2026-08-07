import 'package:flutter/material.dart';

class AppsScreen extends StatelessWidget {
  const AppsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final apps = [
      {'name': '微信', 'icon': Icons.chat, 'color': Colors.green, 'size': '256 MB'},
      {'name': '抖音', 'icon': Icons.movie, 'color': Colors.black, 'size': '312 MB'},
      {'name': '支付宝', 'icon': Icons.payment, 'color': Colors.blue, 'size': '198 MB'},
      {'name': '淘宝', 'icon': Icons.shopping_bag, 'color': Colors.orange, 'size': '287 MB'},
      {'name': 'QQ', 'icon': Icons.message, 'color': Colors.blue, 'size': '345 MB'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('应用管理'), centerTitle: true),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: apps.length,
        itemBuilder: (context, index) {
          final app = apps[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              leading: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: (app['color'] as Color).withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(app['icon'] as IconData, color: app['color'] as Color),
              ),
              title: Text(app['name'] as String),
              subtitle: Text(app['size'] as String, style: const TextStyle(fontSize: 12)),
              trailing: const Icon(Icons.chevron_right),
            ),
          );
        },
      ),
    );
  }
}
