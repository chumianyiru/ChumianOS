import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GestureNavigation extends StatefulWidget {
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
  State<GestureNavigation> createState() => _GestureNavigationState();
}

class _GestureNavigationState extends State<GestureNavigation> {
  static const platform = MethodChannel('com.chumian.launcher/navigation');
  bool _isRootAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkRootStatus();
  }

  Future<void> _checkRootStatus() async {
    try {
      final result = await platform.invokeMethod('isRootAvailable');
      setState(() {
        _isRootAvailable = result ?? false;
      });
    } catch (e) {
      _isRootAvailable = false;
    }
  }

  Future<void> _performBack() async {
    HapticFeedback.lightImpact();
    widget.onBack?.call();
    try {
      await platform.invokeMethod('goBack');
    } catch (e) {
      SystemNavigator.pop();
    }
  }

  Future<void> _performHome() async {
    HapticFeedback.mediumImpact();
    widget.onHome?.call();
    try {
      await platform.invokeMethod('goHome');
    } catch (e) {
      // Fallback: do nothing, already at home
    }
  }

  Future<void> _performRecent() async {
    HapticFeedback.mediumImpact();
    widget.onRecent?.call();
    try {
      final success = await platform.invokeMethod('goRecent');
      if (!success) {
        _showNoRootHint('最近任务');
      }
    } catch (e) {
      _showNoRootHint('最近任务');
    }
  }

  void _showNoRootHint(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$feature 需要无障碍服务或 Root 权限'),
        backgroundColor: Colors.pink,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! > 500) {
          _performBack();
        }
      },
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity != null && details.primaryVelocity! < -500) {
          _performRecent();
        }
      },
      child: Stack(
        children: [
          widget.child,
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.primaryVelocity != null && details.primaryVelocity! < -300) {
                  _performHome();
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
