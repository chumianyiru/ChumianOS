import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../providers/widget_provider.dart';

class DesktopWidgetContainer extends StatefulWidget {
  final DesktopWidget widget;
  final bool isEditMode;
  final VoidCallback onRemove;

  const DesktopWidgetContainer({
    super.key,
    required this.widget,
    required this.isEditMode,
    required this.onRemove,
  });

  @override
  State<DesktopWidgetContainer> createState() => _DesktopWidgetContainerState();
}

class _DesktopWidgetContainerState extends State<DesktopWidgetContainer> {
  DateTime _now = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (_needsTimer(widget.widget.type)) {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() => _now = DateTime.now());
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  bool _needsTimer(String type) {
    return type.startsWith('clock') || type == 'date_display' || type == 'timer';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: widget.isEditMode
            ? Border.all(color: Colors.white.withOpacity(0.5), width: 2)
            : null,
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: _buildWidgetContent(),
          ),
          if (widget.isEditMode)
            Positioned(
              top: 4,
              right: 4,
              child: GestureDetector(
                onTap: widget.onRemove,
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, size: 16, color: Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildWidgetContent() {
    switch (widget.widget.type) {
      case 'clock_digital':
        return _buildDigitalClock();
      case 'clock_analog':
        return _buildAnalogClock();
      case 'clock_flip':
        return _buildFlipClock();
      case 'clock_world':
        return _buildWorldClock();
      case 'date_display':
        return _buildDateDisplay();
      case 'weather':
        return _buildWeather();
      case 'weather_mini':
        return _buildMiniWeather();
      case 'calendar_month':
        return _buildCalendar();
      case 'battery':
        return _buildBattery();
      case 'battery_circle':
        return _buildCircleBattery();
      case 'music':
        return _buildMusic();
      case 'search':
        return _buildSearch();
      case 'notes':
        return _buildNotes();
      case 'cpu':
        return _buildCpu();
      case 'memory':
        return _buildMemory();
      case 'steps':
        return _buildSteps();
      case 'flashlight':
        return _buildFlashlight();
      case 'wifi_toggle':
        return _buildToggle(Icons.wifi, 'WiFi', true);
      case 'bluetooth_toggle':
        return _buildToggle(Icons.bluetooth, '蓝牙', false);
      case 'airplane_toggle':
        return _buildToggle(Icons.airplanemode_active, '飞行', false);
      case 'rotation_toggle':
        return _buildToggle(Icons.screen_rotation, '旋转', true);
      case 'brightness':
        return _buildBrightness();
      case 'sound':
        return _buildSound();
      case 'system_info':
        return _buildSystemInfo();
      case 'todo':
        return _buildTodo();
      case 'moon_phase':
        return _buildMoonPhase();
      case 'sunrise':
        return _buildSunrise();
      case 'photos':
        return _buildPhotos();
      case 'network':
        return _buildNetwork();
      case 'storage':
        return _buildStorage();
      case 'alarm':
        return _buildAlarm();
      case 'timer':
        return _buildTimerWidget();
      case 'calculator':
        return _buildCalculator();
      case 'compass':
        return _buildCompass();
      case 'heart_rate':
        return _buildHeartRate();
      case 'app_shortcuts':
        return _buildAppShortcuts();
      default:
        return _buildPlaceholder();
    }
  }

  Widget _buildDigitalClock() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('HH:mm').format(_now),
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w200,
              color: Colors.white,
              letterSpacing: 2,
              shadows: [Shadow(color: Colors.black45, blurRadius: 8)],
            ),
          ),
          Text(
            DateFormat('ss').format(_now),
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnalogClock() {
    return Center(
      child: CustomPaint(
        size: const Size(70, 70),
        painter: _AnalogClockPainter(_now),
      ),
    );
  }

  Widget _buildFlipClock() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildFlipDigit(_now.hour ~/ 10),
          _buildFlipDigit(_now.hour % 10),
          const Text(':', style: TextStyle(fontSize: 24, color: Colors.white)),
          _buildFlipDigit(_now.minute ~/ 10),
          _buildFlipDigit(_now.minute % 10),
        ],
      ),
    );
  }

  Widget _buildFlipDigit(int digit) {
    return Container(
      width: 24,
      height: 36,
      margin: const EdgeInsets.symmetric(horizontal: 1),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          '$digit',
          style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildWorldClock() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildCityClock('北京', _now),
          _buildCityClock('东京', _now.add(const Duration(hours: 1))),
          _buildCityClock('纽约', _now.subtract(const Duration(hours: 13))),
        ],
      ),
    );
  }

  Widget _buildCityClock(String city, DateTime time) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(city, style: const TextStyle(fontSize: 9, color: Colors.white70)),
        const SizedBox(height: 2),
        Text(
          DateFormat('HH:mm').format(time),
          style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

  Widget _buildDateDisplay() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('MM月dd日').format(_now),
            style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w300),
          ),
          Text(
            DateFormat('EEEE', 'zh_CN').format(_now),
            style: const TextStyle(fontSize: 11, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildWeather() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wb_sunny, size: 32, color: Colors.yellow),
          const SizedBox(height: 4),
          const Text('26°', style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300)),
          Text('晴', style: TextStyle(fontSize: 11, color: Colors.white.withOpacity(0.8))),
        ],
      ),
    );
  }

  Widget _buildMiniWeather() {
    return const Center(
      child: Icon(Icons.wb_sunny, size: 24, color: Colors.yellow),
    );
  }

  Widget _buildCalendar() {
    final now = DateTime.now();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${now.month}月', style: const TextStyle(fontSize: 12, color: Colors.white70)),
          Text('${now.day}', style: const TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
          Text(DateFormat('E', 'zh_CN').format(now), style: const TextStyle(fontSize: 10, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildBattery() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.battery_full, size: 24, color: Colors.green),
          SizedBox(height: 2),
          Text('85%', style: TextStyle(fontSize: 9, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildCircleBattery() {
    return Center(
      child: SizedBox(
        width: 36,
        height: 36,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 36,
              height: 36,
              child: CircularProgressIndicator(
                value: 0.85,
                strokeWidth: 3,
                backgroundColor: Colors.white24,
                valueColor: const AlwaysStoppedAnimation(Colors.green),
              ),
            ),
            const Text('85', style: TextStyle(fontSize: 8, color: Colors.white)),
          ],
        ),
      ),
    );
  }

  Widget _buildMusic() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.pink.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.music_note, color: Colors.white, size: 18),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('歌曲名称', style: TextStyle(fontSize: 11, color: Colors.white), overflow: TextOverflow.ellipsis),
                Text('艺术家', style: TextStyle(fontSize: 9, color: Colors.white70), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          const Icon(Icons.play_arrow, color: Colors.white, size: 20),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.search, size: 16, color: Colors.white70),
          SizedBox(width: 6),
          Text('搜索...', style: TextStyle(fontSize: 12, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildNotes() {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('便签', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Text('• 记得买牛奶\n• 下午3点会议', style: TextStyle(fontSize: 9, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildCpu() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('45%', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 2),
          Text('CPU', style: TextStyle(fontSize: 8, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildMemory() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('62%', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 2),
          Text('内存', style: TextStyle(fontSize: 8, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildSteps() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_walk, size: 18, color: Colors.white),
          SizedBox(height: 2),
          Text('8,234', style: TextStyle(fontSize: 9, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildFlashlight() {
    return const Center(
      child: Icon(Icons.flashlight_off, size: 24, color: Colors.white70),
    );
  }

  Widget _buildToggle(IconData icon, String label, bool active) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? Colors.white : Colors.white24,
            ),
            child: Icon(icon, size: 14, color: active ? Colors.pink : Colors.white70),
          ),
          const SizedBox(height: 3),
          Text(label, style: const TextStyle(fontSize: 8, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildBrightness() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Icon(Icons.brightness_low, size: 14, color: Colors.white70),
          Expanded(
            child: Slider(
              value: 0.7,
              activeColor: Colors.white,
              inactiveColor: Colors.white24,
              onChanged: (_) {},
            ),
          ),
          const Icon(Icons.brightness_high, size: 14, color: Colors.white70),
        ],
      ),
    );
  }

  Widget _buildSound() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Icon(Icons.volume_down, size: 14, color: Colors.white70),
          Expanded(
            child: Slider(
              value: 0.6,
              activeColor: Colors.white,
              inactiveColor: Colors.white24,
              onChanged: (_) {},
            ),
          ),
          const Icon(Icons.volume_up, size: 14, color: Colors.white70),
        ],
      ),
    );
  }

  Widget _buildSystemInfo() {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('ChumianOS', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('CPU', style: TextStyle(fontSize: 9, color: Colors.white70)), Text('45%', style: TextStyle(fontSize: 9, color: Colors.white))]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('内存', style: TextStyle(fontSize: 9, color: Colors.white70)), Text('62%', style: TextStyle(fontSize: 9, color: Colors.white))]),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('存储', style: TextStyle(fontSize: 9, color: Colors.white70)), Text('78%', style: TextStyle(fontSize: 9, color: Colors.white))]),
        ],
      ),
    );
  }

  Widget _buildTodo() {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('待办', style: TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 6),
          Row(children: [Icon(Icons.check_circle, size: 12, color: Colors.green), SizedBox(width: 4), Text('完成报告', style: TextStyle(fontSize: 9, color: Colors.white70, decoration: TextDecoration.lineThrough))]),
          SizedBox(height: 3),
          Row(children: [Icon(Icons.radio_button_unchecked, size: 12, color: Colors.white70), SizedBox(width: 4), Text('回复邮件', style: TextStyle(fontSize: 9, color: Colors.white))]),
        ],
      ),
    );
  }

  Widget _buildMoonPhase() {
    return const Center(
      child: Icon(Icons.nightlight_round, size: 24, color: Colors.yellow),
    );
  }

  Widget _buildSunrise() {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.wb_sunny, size: 14, color: Colors.orange), SizedBox(height: 2), Text('06:23', style: TextStyle(fontSize: 9, color: Colors.white)), Text('日出', style: TextStyle(fontSize: 7, color: Colors.white70))]),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.wb_twilight, size: 14, color: Colors.orange), SizedBox(height: 2), Text('18:45', style: TextStyle(fontSize: 9, color: Colors.white)), Text('日落', style: TextStyle(fontSize: 7, color: Colors.white70))]),
        ],
      ),
    );
  }

  Widget _buildPhotos() {
    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.pink.shade200,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Center(
        child: Icon(Icons.photo, size: 28, color: Colors.white),
      ),
    );
  }

  Widget _buildNetwork() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi, size: 18, color: Colors.white),
          SizedBox(height: 2),
          Text('已连接', style: TextStyle(fontSize: 8, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildStorage() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('78%', style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold)),
          SizedBox(height: 2),
          Text('存储', style: TextStyle(fontSize: 8, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildAlarm() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.alarm, size: 18, color: Colors.white),
          SizedBox(height: 2),
          Text('07:00', style: TextStyle(fontSize: 8, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildTimerWidget() {
    return Center(
      child: Text(
        '${_now.second.toString().padLeft(2, '0')}',
        style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _buildCalculator() {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        children: [
          const Expanded(flex: 1, child: Align(alignment: Alignment.centerRight, child: Text('0', style: TextStyle(fontSize: 16, color: Colors.white)))),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(child: _calcBtn('7')),
                Expanded(child: _calcBtn('8')),
                Expanded(child: _calcBtn('9')),
                Expanded(child: _calcBtn('÷', isOp: true)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _calcBtn(String text, {bool isOp = false}) {
    return Container(
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        color: isOp ? Colors.pink.shade400 : Colors.white24,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(text, style: const TextStyle(fontSize: 10, color: Colors.white)),
      ),
    );
  }

  Widget _buildCompass() {
    return const Center(
      child: Icon(Icons.explore, size: 32, color: Colors.white),
    );
  }

  Widget _buildHeartRate() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite, size: 18, color: Colors.red),
          SizedBox(height: 2),
          Text('72', style: TextStyle(fontSize: 9, color: Colors.white)),
          Text('BPM', style: TextStyle(fontSize: 7, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildAppShortcuts() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _shortcutIcon(Icons.phone, '电话'),
        _shortcutIcon(Icons.message, '短信'),
        _shortcutIcon(Icons.camera, '相机'),
        _shortcutIcon(Icons.settings, '设置'),
      ],
    );
  }

  Widget _shortcutIcon(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: Colors.white),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 7, color: Colors.white)),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return const Center(
      child: Icon(Icons.widgets, size: 20, color: Colors.white54),
    );
  }
}

class _AnalogClockPainter extends CustomPainter {
  final DateTime time;

  _AnalogClockPainter(this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    final paint = Paint()..color = Colors.white.withOpacity(0.3);
    canvas.drawCircle(center, radius, paint);

    final hourAngle = (time.hour % 12 + time.minute / 60) * 30 * 3.14159 / 180 - 1.5708;
    final minuteAngle = (time.minute + time.second / 60) * 6 * 3.14159 / 180 - 1.5708;
    final secondAngle = time.second * 6 * 3.14159 / 180 - 1.5708;

    final hourPaint = Paint()..color = Colors.white..strokeWidth = 3..strokeCap = StrokeCap.round;
    final minutePaint = Paint()..color = Colors.white..strokeWidth = 2..strokeCap = StrokeCap.round;
    final secondPaint = Paint()..color = Colors.pink..strokeWidth = 1..strokeCap = StrokeCap.round;

    canvas.drawLine(center, Offset(center.dx + radius * 0.5 * hourAngle.cos(), center.dy + radius * 0.5 * hourAngle.sin()), hourPaint);
    canvas.drawLine(center, Offset(center.dx + radius * 0.7 * minuteAngle.cos(), center.dy + radius * 0.7 * minuteAngle.sin()), minutePaint);
    canvas.drawLine(center, Offset(center.dx + radius * 0.8 * secondAngle.cos(), center.dy + radius * 0.8 * secondAngle.sin()), secondPaint);

    final dotPaint = Paint()..color = Colors.white;
    canvas.drawCircle(center, 3, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _AnalogClockPainter oldDelegate) => oldDelegate.time != time;
}
