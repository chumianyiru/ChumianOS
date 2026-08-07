import 'package:flutter/material.dart';
import '../theme.dart';

class AppIcon extends StatelessWidget {
  final String appName;
  final IconData icon;
  final Color? bgColor;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final double size;

  const AppIcon({
    super.key,
    required this.appName,
    required this.icon,
    this.bgColor,
    this.onTap,
    this.onLongPress,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    final color = bgColor ?? ChumianTheme.primaryPink;
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: ChumianTheme.softShadow,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: size * 0.5,
            ),
          ),
          SizedBox(height: 6),
          Text(
            appName,
            style: TextStyle(
              fontSize: 12,
              color: ChumianTheme.textDark,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
