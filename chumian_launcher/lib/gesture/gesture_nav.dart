import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GestureNavigation extends StatelessWidget {
  final Widget child;
  final VoidCallback? onBack;
  final VoidCallback? onHome;
  final VoidCallback? onRecent;

  const GestureNavigation({
    super.key,
    required this.child,
    this.onBack,
    this.onHome,
    this.onRecent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! > 500) {
          onBack?.call();
          HapticFeedback.lightImpact();
        }
      },
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! < -500) {
          onRecent?.call();
          HapticFeedback.mediumImpact();
        }
      },
      child: Stack(
        children: [
          child,
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity != null && details.primaryVelocity! < -300) {
                  onHome?.call();
                  HapticFeedback.mediumImpact();
                }
              },
              child: Container(
                height: 30,
                color: Colors.transparent,
                child: Center(
                  child: Container(
                    width: 120,
                    height: 4,
                    margin: EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
