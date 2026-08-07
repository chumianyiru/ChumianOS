import 'package:flutter/material.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('存储'), centerTitle: true),
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
                const SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: 0.78,
                          strokeWidth: 8,
                          backgroundColor: Colors.white24,
                          valueColor: AlwaysStoppedAnimation(Colors.pink),
                        ),
                      ),
                      Text('78%', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text('已使用 99.8 GB / 128 GB', style: TextStyle(fontSize: 14)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildCard([
            _storageItem(Icons.image, '图片', '32.5 GB', Colors.blue),
            _storageItem(Icons.video_library, '视频', '28.3 GB', Colors.purple),
            _storageItem(Icons.music_note, '音乐', '12.1 GB', Colors.green),
            _storageItem(Icons.apps, '应用', '18.7 GB', Colors.orange),
            _storageItem(Icons.file_copy, '其他', '8.2 GB', Colors.grey),
          ]),
        ],
      ),
    );
  }

  Widget _storageItem(IconData icon, String title, String size, Color color) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
        child: Icon(icon, color: color),
      ),
      title: Text(title),
      trailing: Text(size, style: const TextStyle(fontSize: 13)),
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
