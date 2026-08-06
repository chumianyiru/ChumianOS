import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../providers/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ChumianOS 设置'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          // 关于区域（点击7次触发开发者模式）
          _buildAboutCard(context, settings),
          const Divider(indent: 16, endIndent: 16),
          
          // 外观
          _buildSectionHeader(context, '外观'),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('主题'),
            subtitle: Text(_themeName(theme.themeMode)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onTap: () => _showThemePicker(context, theme),
          ),
          ListTile(
            leading: const Icon(Icons.style),
            title: const Text('图标主题'),
            subtitle: Text(settings.iconTheme),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onTap: () => _showIconThemePicker(context, settings),
          ),
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('桌面网格'),
            subtitle: Text('${settings.gridColumns} 列'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onTap: () => _showGridPicker(context, settings),
          ),
          ListTile(
            leading: const Icon(Icons.photo_size_select_small),
            title: const Text('图标大小'),
            subtitle: Text('${settings.iconSize.toInt()}px'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onTap: () => _showIconSizePicker(context, settings),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.label),
            title: const Text('显示应用名称'),
            value: settings.showAppLabels,
            onChanged: (v) => settings.setShowAppLabels(v),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.wallpaper),
            title: const Text('显示状态栏'),
            value: settings.showStatusBar,
            onChanged: (v) => settings.setShowStatusBar(v),
          ),
          
          const Divider(indent: 16, endIndent: 16),
          
          // 系统
          _buildSectionHeader(context, '系统'),
          SwitchListTile(
            secondary: const Icon(Icons.developer_mode),
            title: const Text('开发者选项'),
            subtitle: Text(settings.developerMode ? '已开启' : '已关闭'),
            value: settings.developerMode,
            onChanged: (_) => settings.toggleDeveloperMode(),
          ),
          ListTile(
            leading: const Icon(Icons.android),
            title: const Text('Android 彩蛋'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onTap: () => settings.showEasterEgg(),
          ),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text('文件管理器'),
            subtitle: const Text('内置存储'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onTap: () => _openFileManager(context),
          ),
          ListTile(
            leading: const Icon(Icons.animation),
            title: const Text('动画速度'),
            subtitle: Text(settings.animationSpeed),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onTap: () => _showAnimationPicker(context, settings),
          ),
          
          const Divider(indent: 16, endIndent: 16),
          
          // 系统操作
          _buildSectionHeader(context, '系统操作'),
          ListTile(
            leading: const Icon(Icons.restart_alt, color: Colors.orange),
            title: const Text('重启系统'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onTap: () => _confirmAction(context, '重启', () => settings.rebootSystem()),
          ),
          ListTile(
            leading: const Icon(Icons.power_settings_new, color: Colors.red),
            title: const Text('关机'),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            onTap: () => _confirmAction(context, '关机', () => settings.shutdownSystem()),
          ),
          
          const SizedBox(height: 32),
          Center(
            child: Text(
              'ChumianOS v1.0.0\nPowered by Flutter',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildAboutCard(BuildContext context, SettingsProvider settings) {
    int tapCount = 0;
    return StatefulBuilder(
      builder: (context, setState) {
        return InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: () {
            tapCount++;
            if (tapCount >= 7) {
              settings.toggleDeveloperMode();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(settings.developerMode ? '开发者模式已关闭' : '开发者模式已开启！'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
              );
              tapCount = 0;
            }
          },
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.android,
                    size: 40,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'ChumianOS',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Version 1.0.0 • Android 14',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                if (settings.developerMode)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      '开发者模式已启用',
                      style: TextStyle(fontSize: 11, color: Colors.orange),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  String _themeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light: return '浅色';
      case ThemeMode.dark: return '深色';
      default: return '跟随系统';
    }
  }

  void _showThemePicker(BuildContext context, ThemeProvider theme) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('跟随系统'),
              trailing: theme.themeMode == ThemeMode.system ? const Icon(Icons.check) : null,
              onTap: () { theme.setTheme(ThemeMode.system); Navigator.pop(context); },
            ),
            ListTile(
              title: const Text('浅色模式'),
              trailing: theme.themeMode == ThemeMode.light ? const Icon(Icons.check) : null,
              onTap: () { theme.setTheme(ThemeMode.light); Navigator.pop(context); },
            ),
            ListTile(
              title: const Text('深色模式'),
              trailing: theme.themeMode == ThemeMode.dark ? const Icon(Icons.check) : null,
              onTap: () { theme.setTheme(ThemeMode.dark); Navigator.pop(context); },
            ),
          ],
        ),
      ),
    );
  }

  void _showIconThemePicker(BuildContext context, SettingsProvider settings) {
    final themes = ['default', 'rounded', 'material', 'ios', 'neumorphic', 
                    'glass', 'minimal', 'neon', 'cartoon', 'pixel'];
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: themes.map((t) => ListTile(
            title: Text(t),
            leading: CircleAvatar(
              radius: 16,
              child: Text(t[0].toUpperCase(), style: const TextStyle(fontSize: 12)),
            ),
            trailing: settings.iconTheme == t ? const Icon(Icons.check) : null,
            onTap: () { settings.setIconTheme(t); Navigator.pop(context); },
          )).toList(),
        ),
      ),
    );
  }

  void _showGridPicker(BuildContext context, SettingsProvider settings) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [3, 4, 5, 6].map((c) => ListTile(
            title: Text('$c 列'),
            trailing: settings.gridColumns == c ? const Icon(Icons.check) : null,
            onTap: () { settings.setGridColumns(c); Navigator.pop(context); },
          )).toList(),
        ),
      ),
    );
  }

  void _showIconSizePicker(BuildContext context, SettingsProvider settings) {
    showModalBottomSheet(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('图标大小', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  Slider(
                    value: settings.iconSize,
                    min: 48,
                    max: 96,
                    divisions: 8,
                    label: '${settings.iconSize.toInt()}',
                    onChanged: (v) => setState(() => settings.setIconSize(v)),
                  ),
                  Text('${settings.iconSize.toInt()}px'),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('确定'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showAnimationPicker(BuildContext context, SettingsProvider settings) {
    final speeds = ['slow', 'normal', 'fast'];
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: speeds.map((s) => ListTile(
            title: Text(s),
            trailing: settings.animationSpeed == s ? const Icon(Icons.check) : null,
            onTap: () { settings.setAnimationSpeed(s); Navigator.pop(context); },
          )).toList(),
        ),
      ),
    );
  }

  void _openFileManager(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FileManagerScreen()),
    );
  }

  void _confirmAction(BuildContext context, String action, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('确认$action？'),
        content: Text('系统将$action，请确认。'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),
          FilledButton(
            onPressed: () { Navigator.pop(context); onConfirm(); },
            child: Text(action),
          ),
        ],
      ),
    );
  }
}

class FileManagerScreen extends StatelessWidget {
  const FileManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文件管理器'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.folder, color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            title: const Text('内部存储'),
            subtitle: const Text('45.2 GB / 128 GB'),
            onTap: () {},
          ),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.image, color: Colors.blue),
            ),
            title: const Text('图片'),
            onTap: () {},
          ),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.music_note, color: Colors.green),
            ),
            title: const Text('音乐'),
            onTap: () {},
          ),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.video_library, color: Colors.purple),
            ),
            title: const Text('视频'),
            onTap: () {},
          ),
          ListTile(
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.download, color: Colors.orange),
            ),
            title: const Text('下载'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
