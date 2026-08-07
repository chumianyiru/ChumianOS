import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/settings_provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final theme = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('启动器设置'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          _buildSectionHeader(context, '主题'),
          ...AppTheme.themeList.map((t) => ListTile(
            leading: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: t['color'] as Color,
                shape: BoxShape.circle,
              ),
            ),
            title: Text(t['displayName'] as String),
            trailing: theme.currentTheme == t['name'] ? const Icon(Icons.check, color: Colors.green) : null,
            onTap: () => theme.setTheme(t['name'] as String),
          )),
          
          const Divider(indent: 16, endIndent: 16),
          
          _buildSectionHeader(context, '外观'),
          ListTile(
            leading: const Icon(Icons.grid_view),
            title: const Text('桌面网格'),
            subtitle: Text('${settings.gridColumns} 列'),
            onTap: () => _showGridPicker(context, settings),
          ),
          ListTile(
            leading: const Icon(Icons.photo_size_select_small),
            title: const Text('图标大小'),
            subtitle: Text('${settings.iconSize.toInt()}px'),
            onTap: () => _showIconSizePicker(context, settings),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.label),
            title: const Text('显示应用名称'),
            value: settings.showAppLabels,
            onChanged: (_) => settings.toggleAppLabels(),
          ),
          SwitchListTile(
            secondary: const Icon(Icons.wallpaper),
            title: const Text('显示状态栏'),
            value: settings.showStatusBar,
            onChanged: (_) => settings.toggleStatusBar(),
          ),
          
          const Divider(indent: 16, endIndent: 16),
          
          _buildSectionHeader(context, '关于'),
          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('ChumianOS Launcher'),
            subtitle: Text('Version 1.0.0'),
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
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
                    max: 80,
                    divisions: 8,
                    label: '${settings.iconSize.toInt()}',
                    onChanged: (v) => setState(() => settings.setIconSize(v)),
                  ),
                  Text('${settings.iconSize.toInt()}px'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
