import 'package:flutter/material.dart';
import '../theme.dart';

class LongPressMenuSheet extends StatelessWidget {
  final String appName;
  final VoidCallback onDelete;
  final VoidCallback onInfo;
  final VoidCallback onShortcut;

  const LongPressMenuSheet({
    super.key,
    required this.appName,
    required this.onDelete,
    required this.onInfo,
    required this.onShortcut,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: ChumianTheme.lightPink,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: ChumianTheme.primaryPink,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.apps, color: Colors.white, size: 24),
                  ),
                  SizedBox(width: 16),
                  Text(
                    appName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ChumianTheme.textDark,
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            _MenuItem(
              icon: Icons.flash_on,
              title: '快捷指令',
              subtitle: '快速执行常用操作',
              onTap: onShortcut,
            ),
            _MenuItem(
              icon: Icons.info_outline,
              title: '应用信息',
              subtitle: '查看应用详情和权限',
              onTap: onInfo,
            ),
            _MenuItem(
              icon: Icons.delete_outline,
              title: '删除应用',
              subtitle: '从桌面移除该应用',
              isDestructive: true,
              onTap: onDelete,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? Colors.red : ChumianTheme.primaryPink;
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red : ChumianTheme.textDark,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: ChumianTheme.textDark.withOpacity(0.6),
          fontSize: 13,
        ),
      ),
      onTap: onTap,
    );
  }
}
