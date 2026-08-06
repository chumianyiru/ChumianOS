import 'dart:convert';
import 'package:flutter/material.dart';
import '../providers/app_provider.dart';

class AppIcon extends StatelessWidget {
  final AppInfo app;
  final double size;
  final bool isEditMode;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const AppIcon({
    super.key,
    required this.app,
    required this.size,
    required this.isEditMode,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconWidget;
    
    if (app.iconBase64 != null) {
      try {
        final bytes = base64Decode(app.iconBase64!);
        iconWidget = Image.memory(bytes, width: size, height: size, fit: BoxFit.cover);
      } catch (e) {
        iconWidget = Icon(Icons.android, size: size * 0.5);
      }
    } else {
      iconWidget = Icon(Icons.android, size: size * 0.5);
    }

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(child: iconWidget),
              ),
              if (isEditMode)
                Positioned(
                  top: -2,
                  right: -2,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.close, size: 12, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            app.appName,
            style: TextStyle(
              fontSize: 11,
              color: Colors.white.withOpacity(0.95),
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.6),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
