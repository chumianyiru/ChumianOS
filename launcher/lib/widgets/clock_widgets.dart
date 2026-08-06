import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnalogClockWidget extends StatefulWidget {
  const AnalogClockWidget({super.key});

  @override
  State<AnalogClockWidget> createState() => _AnalogClockWidgetState();
}

class _AnalogClockWidgetState extends State<AnalogClockWidget> {
  Timer? _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AnalogClockPainter(_now, Theme.of(context).colorScheme),
      child: Container(),
    );
  }
}

class _AnalogClockPainter extends CustomPainter {
  final DateTime time;
  final ColorScheme scheme;

  _AnalogClockPainter(this.time, this.scheme);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 8;

    // Background
    final bgPaint = Paint()
      ..color = scheme.surfaceVariant.withOpacity(0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, bgPaint);

    // Border
    final borderPaint = Paint()
      ..color = scheme.outline.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, borderPaint);

    // Hour markers
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30 - 90) * pi / 180;
      final inner = radius - 8;
      final outer = radius - 4;
      final p1 = Offset(center.dx + inner * cos(angle), center.dy + inner * sin(angle));
      final p2 = Offset(center.dx + outer * cos(angle), center.dy + outer * sin(angle));
      canvas.drawLine(p1, p2, Paint()..color = scheme.onSurface..strokeWidth = 2);
    }

    // Hour hand
    final hourAngle = ((time.hour % 12) * 30 + time.minute * 0.5 - 90) * pi / 180;
    final hourEnd = Offset(
      center.dx + (radius * 0.5) * cos(hourAngle),
      center.dy + (radius * 0.5) * sin(hourAngle),
    );
    canvas.drawLine(center, hourEnd, Paint()..color = scheme.onSurface..strokeWidth = 4..strokeCap = StrokeCap.round);

    // Minute hand
    final minuteAngle = (time.minute * 6 + time.second * 0.1 - 90) * pi / 180;
    final minuteEnd = Offset(
      center.dx + (radius * 0.7) * cos(minuteAngle),
      center.dy + (radius * 0.7) * sin(minuteAngle),
    );
    canvas.drawLine(center, minuteEnd, Paint()..color = scheme.onSurface..strokeWidth = 3..strokeCap = StrokeCap.round);

    // Second hand
    final secondAngle = (time.second * 6 - 90) * pi / 180;
    final secondEnd = Offset(
      center.dx + (radius * 0.8) * cos(secondAngle),
      center.dy + (radius * 0.8) * sin(secondAngle),
    );
    canvas.drawLine(center, secondEnd, Paint()..color = scheme.primary..strokeWidth = 2..strokeCap = StrokeCap.round);

    // Center dot
    canvas.drawCircle(center, 4, Paint()..color = scheme.primary);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DigitalClockWidget extends StatefulWidget {
  const DigitalClockWidget({super.key});

  @override
  State<DigitalClockWidget> createState() => _DigitalClockWidgetState();
}

class _DigitalClockWidgetState extends State<DigitalClockWidget> {
  Timer? _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeStr = DateFormat('HH:mm').format(_now);
    final dateStr = DateFormat('MM月dd日 EEEE').format(_now);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            timeStr,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w200,
              color: Theme.of(context).colorScheme.onSurface,
              letterSpacing: 2,
            ),
          ),
          Text(
            dateStr,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }
}

class FlipClockWidget extends StatefulWidget {
  const FlipClockWidget({super.key});

  @override
  State<FlipClockWidget> createState() => _FlipClockWidgetState();
}

class _FlipClockWidgetState extends State<FlipClockWidget> {
  Timer? _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildFlipDigit(String digit) {
    return Container(
      width: 28,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          digit,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hour = _now.hour.toString().padLeft(2, '0');
    final minute = _now.minute.toString().padLeft(2, '0');
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildFlipDigit(hour[0]),
          _buildFlipDigit(hour[1]),
          Text(':', style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.onSurface)),
          _buildFlipDigit(minute[0]),
          _buildFlipDigit(minute[1]),
        ],
      ),
    );
  }
}

class WorldClockWidget extends StatefulWidget {
  const WorldClockWidget({super.key});

  @override
  State<WorldClockWidget> createState() => _WorldClockWidgetState();
}

class _WorldClockWidgetState extends State<WorldClockWidget> {
  Timer? _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _getTimeForZone(int offset) {
    final utc = _now.toUtc();
    final local = utc.add(Duration(hours: offset));
    return DateFormat('HH:mm').format(local);
  }

  @override
  Widget build(BuildContext context) {
    final cities = [
      {'name': '北京', 'offset': 8},
      {'name': '纽约', 'offset': -5},
      {'name': '伦敦', 'offset': 0},
      {'name': '东京', 'offset': 9},
    ];
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: cities.map((c) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(c['name'] as String, style: const TextStyle(fontSize: 11)),
              Text(_getTimeForZone(c['offset'] as int), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
        )).toList(),
      ),
    );
  }
}

class AlarmWidget extends StatelessWidget {
  const AlarmWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.alarm, size: 28),
          SizedBox(height: 4),
          Text('07:30', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  int _seconds = 0;
  bool _running = false;
  Timer? _timer;

  void _toggle() {
    if (_running) {
      _timer?.cancel();
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        setState(() => _seconds++);
      });
    }
    setState(() => _running = !_running);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$m:$s', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: _toggle,
            child: Icon(_running ? Icons.pause : Icons.play_arrow, size: 20),
          ),
        ],
      ),
    );
  }
}
