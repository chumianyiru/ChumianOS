import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme.dart';

class ClockWidget extends StatefulWidget {
  final bool isDark;
  const ClockWidget({super.key, this.isDark = false});

  @override
  State<ClockWidget> createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late DateTime _now;
  late String _timeStr;
  late String _dateStr;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    _timeStr = DateFormat('HH:mm').format(_now);
    _dateStr = DateFormat('EEEE, MMMM d', 'zh_CN').format(_now);
    _tick();
  }

  void _tick() {
    Future.delayed(Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() {
        _now = DateTime.now();
        _timeStr = DateFormat('HH:mm').format(_now);
        _dateStr = DateFormat('EEEE, MMMM d', 'zh_CN').format(_now);
      });
      _tick();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textColor = widget.isDark ? Colors.white : ChumianTheme.textDark;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _timeStr,
          style: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w200,
            color: textColor,
            letterSpacing: 2,
          ),
        ),
        SizedBox(height: 4),
        Text(
          _dateStr,
          style: TextStyle(
            fontSize: 16,
            color: textColor.withOpacity(0.7),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
