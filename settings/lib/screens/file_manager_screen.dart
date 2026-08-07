import 'package:flutter/material.dart';

class FileManagerScreen extends StatelessWidget {
  const FileManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final folders = [
      {'name': '图片', 'icon': Icons.image, 'color': Colors.blue, 'count': '1,234 项'},
      {'name': '视频', 'icon': Icons.video_library, 'color': Colors.purple, 'count': '56 项'},
      {'name': '音乐', 'icon': Icons.music_note, 'color': Colors.green, 'count': '345 项'},
      {'name': '下载', 'icon': Icons.download, 'color': Colors.orange, 'count': '89 项'},
      {'name': '文档', 'icon': Icons.description, 'color': Colors.blueGrey, 'count': '123 项'},
      {'name': '安装包', 'icon': Icons.android, 'color': Colors.green, 'count': '12 项'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('文件管理'),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.sd_storage, size: 32),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('内部存储', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text('99.8 GB 已使用 / 128 GB 总计', style: TextStyle(fontSize: 12)),
                      SizedBox(height: 4),
                      LinearProgressIndicator(value: 0.78, minHeight: 4),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: folders.length,
            itemBuilder: (context, index) {
              final folder = folders[index];
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: (folder['color'] as Color).withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(folder['icon'] as IconData, color: folder['color'] as Color),
                    ),
                    const SizedBox(height: 8),
                    Text(folder['name'] as String, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 2),
                    Text(folder['count'] as String, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
