import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../providers/app_provider.dart';

class AppIcon extends StatelessWidget {
  final AppInfo app;
  final double size;
  final bool isEditMode;
  final bool showLabel;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const AppIcon({
    super.key,
    required this.app,
    required this.size,
    required this.isEditMode,
    this.showLabel = true,
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
        iconWidget = Icon(Icons.android, size: size * 0.5, color: Colors.white);
      }
    } else {
      iconWidget = Icon(Icons.android, size: size * 0.5, color: Colors.white);
    }

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      onLongPress: () {
        HapticFeedback.mediumImpact();
        onLongPress();
      },
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
                  color: Colors.white.withOpacity(0.15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: ClipOval(child: iconWidget),
              ),
              if (isEditMode)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.close, size: 12, color: Colors.white),
                  ),
                ),
            ],
          ),
          if (showLabel) ...[
            const SizedBox(height: 6),
            Text(
              app.appName,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withOpacity(0.95),
                fontWeight: FontWeight.w400,
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
        ],
      ),
    );
  }
}
