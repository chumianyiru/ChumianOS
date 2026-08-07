import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/app_provider.dart';
import '../providers/widget_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/app_icon.dart';
import '../widgets/desktop_widget_container.dart';
import '../widgets/notification_shade.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  bool _showWidgetPicker = false;
  DateTime _now = DateTime.now();
  Timer? _timer;
  final ScrollController _scrollController = ScrollController();
  double _dragStartY = 0;
  double _notificationDrag = 0;

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
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onVerticalDragStart: (details) {
          _dragStartY = details.globalPosition.dy;
        },
        onVerticalDragUpdate: (details) {
          if (_dragStartY < 50) {
            setState(() {
              _notificationDrag = (details.globalPosition.dy - _dragStartY).clamp(0.0, 400.0);
            });
          }
        },
        onVerticalDragEnd: (details) {
          if (_notificationDrag > 150) {
            settings.expandNotifications();
          }
          setState(() => _notificationDrag = 0);
        },
        onLongPress: () {
          HapticFeedback.mediumImpact();
          settings.toggleEditMode();
        },
        child: Container(
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
            child: Container(
              color: Colors.black.withOpacity(0.1),
              child: SafeArea(
                child: Stack(
                  children: [
                    _buildTopBar(themeProvider),
                    _buildWidgetArea(widgetProvider, settings),
                    _buildAppGrid(appProvider, settings),
                    if (settings.isEditMode) _buildEditModeBottomSheet(),
                    if (_showWidgetPicker) _buildWidgetPicker(widgetProvider),
                    if (settings.notificationsExpanded) _buildNotificationShade(settings),
                    if (_notificationDrag > 0) _buildNotificationPreview(_notificationDrag),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(ThemeProvider themeProvider) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'chumian',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                letterSpacing: 2,
                shadows: [Shadow(color: Colors.black45, blurRadius: 8)],
              ),
            ),
            GestureDetector(
              onTap: () => themeProvider.nextTheme(),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.5),
                ),
                child: const Icon(Icons.palette, size: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetArea(WidgetProvider widgetProvider, SettingsProvider settings) {
    return Positioned(
      top: 52,
      left: 0,
      right: 0,
      height: 180,
      child: IgnorePointer(
        ignoring: !settings.isEditMode,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final colWidth = constraints.maxWidth / 4;
              final rowHeight = 90.0;
              return Stack(
                children: widgetProvider.widgets.map((w) {
                  return Positioned(
                    left: w.x * colWidth,
                    top: w.y * rowHeight,
                    width: w.width * colWidth - 8,
                    height: w.height * rowHeight - 8,
                    child: DesktopWidgetContainer(
                      widget: w,
                      isEditMode: settings.isEditMode,
                      onRemove: () => widgetProvider.removeWidget(w.id),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAppGrid(AppProvider provider, SettingsProvider settings) {
    final apps = provider.apps;
    if (provider.isLoading) {
      return const Positioned(
        bottom: 100,
        left: 0,
        right: 0,
        child: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }
    return Positioned(
      top: 240,
      left: 0,
      right: 0,
      bottom: 0,
      child: GridView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: settings.gridColumns,
          childAspectRatio: 0.72,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: apps.length,
        itemBuilder: (context, index) {
          final app = apps[index];
          return AppIcon(
            app: app,
            size: settings.iconSize,
            isEditMode: settings.isEditMode,
            showLabel: settings.showAppLabels,
            onTap: () => provider.launchApp(app.packageName),
            onLongPress: () => _showAppOptions(context, app, provider),
          );
        },
      ),
    );
  }

  void _showAppOptions(BuildContext context, AppInfo app, AppProvider provider) {
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
                    width: 52,
                    height: 52,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          app.appName,
                          style: Theme.of(context).textTheme.titleLarge,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          app.packageName,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (app.shortcuts.isNotEmpty)
                ...app.shortcuts.map((s) => ListTile(
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                    child: Icon(Icons.shortcut, color: Theme.of(context).colorScheme.onSecondaryContainer, size: 20),
                  ),
                  title: Text(s),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  onTap: () => Navigator.pop(ctx),
                )),
              ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                  child: Icon(Icons.delete_outline, color: Theme.of(context).colorScheme.onErrorContainer, size: 20),
                ),
                title: const Text('卸载应用'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                onTap: () {
                  Navigator.pop(ctx);
                  provider.uninstallApp(app.packageName);
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.onSurface, size: 20),
                ),
                title: const Text('应用信息'),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                onTap: () {
                  Navigator.pop(ctx);
                  provider.openAppInfo(app.packageName);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditModeBottomSheet() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.95),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20)],
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildEditAction(Icons.widgets, '添加组件', () {
                    setState(() => _showWidgetPicker = true);
                  }),
                  _buildEditAction(Icons.settings, '启动器设置', () {
                    Navigator.pushNamed(context, '/settings');
                  }),
                  _buildEditAction(Icons.wallpaper, '壁纸', () {}),
                  _buildEditAction(Icons.done, '完成', () {
                    context.read<SettingsProvider>().exitEditMode();
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditAction(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Icon(icon, color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildWidgetPicker(WidgetProvider provider) {
    final categories = {'时间', '生活', '系统', '工具', '快捷', '娱乐', '健康'};
    return Positioned.fill(
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: const Text('选择桌面组件'),
                leading: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => setState(() => _showWidgetPicker = false),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: categories.map((cat) {
                    final widgets = provider.availableWidgets.where((w) => w['category'] == cat).toList();
                    if (widgets.isEmpty) return const SizedBox.shrink();
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Text(cat, style: Theme.of(context).textTheme.titleMedium),
                        ),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: 0.85,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: widgets.length,
                          itemBuilder: (context, index) {
                            final w = widgets[index];
                            return GestureDetector(
                              onTap: () {
                                provider.addWidget(w['type'] as String);
                                setState(() => _showWidgetPicker = false);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(w['icon'] as IconData, size: 24, color: Theme.of(context).colorScheme.primary),
                                    const SizedBox(height: 6),
                                    Text(w['name'] as String, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10)),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationShade(SettingsProvider settings) {
    return NotificationShade(
      onClose: () => settings.collapseNotifications(),
      currentTime: DateFormat('HH:mm').format(_now),
    );
  }

  Widget _buildNotificationPreview(double dragAmount) {
    final progress = (dragAmount / 400).clamp(0.0, 1.0);
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Transform.translate(
        offset: Offset(0, -400 + dragAmount),
        child: Opacity(
          opacity: progress,
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.pink.shade100.withOpacity(0.95),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat('HH:mm').format(_now), style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink)),
                        const Icon(Icons.notifications, color: Colors.pink),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('下拉查看通知', style: TextStyle(color: Colors.pink.shade300)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
