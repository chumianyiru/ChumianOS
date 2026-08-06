import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../providers/widget_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/app_icon.dart';
import '../widgets/desktop_widget_container.dart';
import '../widgets/gesture_overlay.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  bool _isEditMode = false;
  bool _showWidgetPicker = false;
  DateTime _now = DateTime.now();
  Timer? _timer;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = context.watch<AppProvider>();
    final widgetProvider = context.watch<WidgetProvider>();
    final settings = context.watch<SettingsProvider>();

    return GestureOverlay(
      onSwipeUp: () => _scrollToTop(),
      onSwipeDown: () => settings.expandNotifications(),
      onSwipeLeft: () => _openRecents(),
      onSwipeRight: () => _goBack(),
      onLongPress: () => setState(() => _isEditMode = true),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/wallpapers/default.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: settings.wallpaperBlur,
              sigmaY: settings.wallpaperBlur,
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  // 桌面组件层
                  _buildWidgetLayer(widgetProvider),
                  
                  // 应用网格层
                  _buildAppGrid(appProvider, settings),
                  
                  // 编辑模式遮罩
                  if (_isEditMode) _buildEditModeOverlay(),
                  
                  // 组件选择器
                  if (_showWidgetPicker) _buildWidgetPicker(widgetProvider),
                  
                  // 状态栏
                  if (settings.showStatusBar) _buildStatusBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetLayer(WidgetProvider provider) {
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: _isEditMode,
        child: Stack(
          children: provider.widgets.map((w) {
            return DesktopWidgetContainer(
              widget: w,
              isEditMode: _isEditMode,
              onRemove: () => provider.removeWidget(w.id),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildAppGrid(AppProvider provider, SettingsProvider settings) {
    final apps = provider.apps;
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.1,
      maxChildSize: 0.92,
      controller: DraggableScrollableController(),
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.82),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            children: [
              // 拖拽指示器
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // 应用网格
              Expanded(
                child: GridView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: settings.gridColumns,
                    childAspectRatio: 0.78,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: apps.length,
                  itemBuilder: (context, index) {
                    final app = apps[index];
                    return AppIcon(
                      app: app,
                      size: settings.iconSize,
                      isEditMode: _isEditMode,
                      onTap: () => provider.launchApp(app.packageName),
                      onLongPress: () => _showAppOptions(context, app),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAppOptions(BuildContext context, AppInfo app) {
    HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    child: app.iconBase64 != null
                        ? ClipOval(child: Image.memory(base64Decode(app.iconBase64!), fit: BoxFit.cover))
                        : Icon(Icons.android, color: Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      app.appName,
                      style: Theme.of(context).textTheme.titleLarge,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.delete_outline),
                title: const Text('卸载应用'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                onTap: () {
                  Navigator.pop(ctx);
                  context.read<AppProvider>().uninstallApp(app.packageName);
                },
              ),
              ListTile(
                leading: const Icon(Icons.info_outline),
                title: const Text('应用信息'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                onTap: () {
                  Navigator.pop(ctx);
                  _showAppInfo(context, app);
                },
              ),
              if (app.shortcuts.isNotEmpty)
                ...app.shortcuts.map((s) => ListTile(
                  leading: const Icon(Icons.shortcut),
                  title: Text(s),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  onTap: () {},
                )),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  void _showAppInfo(BuildContext context, AppInfo app) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(app.appName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('包名: ${app.packageName}'),
            Text('系统应用: ${app.isSystemApp ? "是" : "否"}'),
            Text('状态: ${app.isEnabled ? "已启用" : "已禁用"}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('关闭')),
        ],
      ),
    );
  }

  Widget _buildEditModeOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black54,
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Container(
                margin: const EdgeInsets.all(24),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.edit, size: 48),
                    const SizedBox(height: 16),
                    Text('编辑模式', style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: () => setState(() => _showWidgetPicker = true),
                      icon: const Icon(Icons.widgets),
                      label: const Text('添加组件'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    FilledButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/settings'),
                      icon: const Icon(Icons.settings),
                      label: const Text('启动器设置'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () => setState(() => _isEditMode = false),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      ),
                      child: const Text('完成'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetPicker(WidgetProvider provider) {
    return Positioned.fill(
      child: Container(
        color: Colors.black87,
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: const Text('选择组件'),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _showWidgetPicker = false),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: provider.availableWidgets.length,
                  itemBuilder: (context, index) {
                    final w = provider.availableWidgets[index];
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: InkWell(
                        onTap: () {
                          provider.addWidget(w['type'] as String);
                          setState(() => _showWidgetPicker = false);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(w['icon'] as IconData, size: 32),
                            const SizedBox(height: 8),
                            Text(w['name'] as String, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              DateFormat('HH:mm').format(_now),
              style: const TextStyle(fontSize: 12, color: Colors.white, shadows: [Shadow(color: Colors.black, blurRadius: 4)]),
            ),
            Row(
              children: [
                const Icon(Icons.signal_cellular_alt, size: 14, color: Colors.white),
                const SizedBox(width: 4),
                const Icon(Icons.wifi, size: 14, color: Colors.white),
                const SizedBox(width: 4),
                const Icon(Icons.battery_full, size: 14, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToTop() {}
  void _openRecents() {}
  void _goBack() {}
}
