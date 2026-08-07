import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class LockScreen extends StatefulWidget {
  const LockScreen({super.key});

  @override
  State<LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<LockScreen> {
  DateTime _now = DateTime.now();
  Timer? _timer;
  double _dragY = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          setState(() {
            _dragY = (_dragY + details.delta.dy).clamp(-300.0, 0.0);
          });
        },
        onVerticalDragEnd: (details) {
          if (_dragY < -150) {
            Navigator.of(context).pushReplacementNamed('/');
          } else {
            setState(() => _dragY = 0);
          }
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/wallpapers/default.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.2),
            child: Transform.translate(
              offset: Offset(0, _dragY),
              child: SafeArea(
                child: Column(
                  children: [
                    const Spacer(flex: 2),
                    _buildClock(),
                    const SizedBox(height: 8),
                    _buildDate(),
                    const Spacer(flex: 3),
                    _buildNotifications(),
                    const Spacer(),
                    _buildUnlockHint(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClock() {
    return Center(
      child: Text(
        DateFormat('HH:mm').format(_now),
        style: const TextStyle(
          fontSize: 72,
          fontWeight: FontWeight.w200,
          color: Colors.white,
          letterSpacing: 4,
          shadows: [Shadow(color: Colors.black45, blurRadius: 12)],
        ),
      ),
    );
  }

  Widget _buildDate() {
    return Center(
      child: Text(
        DateFormat('MM月dd日 EEEE', 'zh_CN').format(_now),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white70,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildNotifications() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green.withOpacity(0.3),
                ),
                child: const Icon(Icons.chat, size: 18, color: Colors.white),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('微信', style: TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('你有3条未读消息', style: TextStyle(fontSize: 12, color: Colors.white70)),
                  ],
                ),
              ),
              const Text('刚刚', style: TextStyle(fontSize: 11, color: Colors.white54)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUnlockHint() {
    return Column(
      children: [
        const Icon(Icons.keyboard_arrow_up, size: 32, color: Colors.white70),
        const SizedBox(height: 4),
        Text(
          '上滑解锁',
          style: TextStyle(
            fontSize: 13,
            color: Colors.white.withOpacity(0.7),
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }
}
