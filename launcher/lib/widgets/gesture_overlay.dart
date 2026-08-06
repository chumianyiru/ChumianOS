import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GestureOverlay extends StatefulWidget {
  final Widget child;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onLongPress;
  final VoidCallback? onDoubleTap;

  const GestureOverlay({
    super.key,
    required this.child,
    this.onSwipeUp,
    this.onSwipeDown,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onLongPress,
    this.onDoubleTap,
  });

  @override
  State<GestureOverlay> createState() => _GestureOverlayState();
}

class _GestureOverlayState extends State<GestureOverlay> {
  double _startX = 0;
  double _startY = 0;
  double _lastX = 0;
  double _lastY = 0;
  DateTime _startTime = DateTime.now();
  bool _isGestureActive = false;

  static const double _swipeThreshold = 80;
  static const double _edgeThreshold = 30;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: (details) {
        _startX = details.globalPosition.dx;
        _startY = details.globalPosition.dy;
        _lastX = _startX;
        _lastY = _startY;
        _startTime = DateTime.now();
        _isGestureActive = true;
      },
      onPanUpdate: (details) {
        _lastX = details.globalPosition.dx;
        _lastY = details.globalPosition.dy;
      },
      onPanEnd: (details) {
        if (!_isGestureActive) return;
        _isGestureActive = false;

        final dx = _lastX - _startX;
        final dy = _lastY - _startY;
        final absDx = dx.abs();
        final absDy = dy.abs();
        final velocity = details.velocity.pixelsPerSecond;

        // Edge gestures
        final size = MediaQuery.of(context).size;
        final isLeftEdge = _startX < _edgeThreshold;
        final isRightEdge = _startX > size.width - _edgeThreshold;
        final isBottomEdge = _startY > size.height - _edgeThreshold;
        final isTopEdge = _startY < _edgeThreshold;

        if (absDx > absDy) {
          if (absDx > _swipeThreshold) {
            if (dx > 0) {
              if (isLeftEdge) {
                HapticFeedback.mediumImpact();
                widget.onSwipeRight?.call();
              }
            } else {
              if (isRightEdge) {
                HapticFeedback.mediumImpact();
                widget.onSwipeLeft?.call();
              }
            }
          }
        } else {
          if (absDy > _swipeThreshold) {
            if (dy > 0) {
              if (isTopEdge) {
                HapticFeedback.mediumImpact();
                widget.onSwipeDown?.call();
              }
            } else {
              if (isBottomEdge) {
                HapticFeedback.mediumImpact();
                widget.onSwipeUp?.call();
              }
            }
          }
        }
      },
      onLongPress: () {
        HapticFeedback.heavyImpact();
        widget.onLongPress?.call();
      },
      onDoubleTap: () {
        HapticFeedback.lightImpact();
        widget.onDoubleTap?.call();
      },
      child: widget.child,
    );
  }
}
