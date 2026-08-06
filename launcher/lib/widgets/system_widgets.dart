import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(Icons.wb_sunny, size: 32, color: Colors.orange.shade400),
              const SizedBox(width: 8),
              const Text('26°', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w300)),
            ],
          ),
          const SizedBox(height: 4),
          const Text('晴朗', style: TextStyle(fontSize: 12)),
          const Text('H:30° L:18°', style: TextStyle(fontSize: 10, color: Colors.grey)),
        ],
      ),
    );
  }
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('MMMM').format(now),
            style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
          ),
          Text(
            '${now.day}',
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          Text(
            DateFormat('EEEE').format(now),
            style: const TextStyle(fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class BatteryWidget extends StatefulWidget {
  const BatteryWidget({super.key});

  @override
  State<BatteryWidget> createState() => _BatteryWidgetState();
}

class _BatteryWidgetState extends State<BatteryWidget> {
  final Battery _battery = Battery();
  int _level = 80;
  BatteryState _state = BatteryState.unknown;

  @override
  void initState() {
    super.initState();
    _battery.onBatteryStateChanged.listen((state) async {
      final level = await _battery.batteryLevel;
      setState(() {
        _level = level;
        _state = state;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = _level > 50 ? Colors.green : _level > 20 ? Colors.orange : Colors.red;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.battery_full, size: 32, color: color),
              Text('$_level%', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          if (_state == BatteryState.charging)
            const Icon(Icons.bolt, size: 12, color: Colors.yellow),
        ],
      ),
    );
  }
}

class MusicWidget extends StatelessWidget {
  const MusicWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            children: [
              Icon(Icons.music_note, size: 16),
              SizedBox(width: 4),
              Expanded(
                child: Text('未在播放', style: TextStyle(fontSize: 11), overflow: TextOverflow.ellipsis),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.skip_previous, size: 20, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.play_arrow, size: 18, color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
              Icon(Icons.skip_next, size: 20, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5)),
            ],
          ),
        ],
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          children: [
            SizedBox(width: 12),
            Icon(Icons.search, size: 18),
            SizedBox(width: 8),
            Text('搜索应用...', style: TextStyle(fontSize: 13, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class NotesWidget extends StatefulWidget {
  const NotesWidget({super.key});

  @override
  State<NotesWidget> createState() => _NotesWidgetState();
}

class _NotesWidgetState extends State<NotesWidget> {
  String _note = '点击添加便签...';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.sticky_note_2, size: 14),
                SizedBox(width: 4),
                Text('便签', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Text(
                _note,
                style: const TextStyle(fontSize: 11),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhotosWidget extends StatelessWidget {
  const PhotosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade200, Colors.blue.shade200],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(Icons.photo_library, size: 32, color: Colors.white70),
      ),
    );
  }
}

class CpuWidget extends StatefulWidget {
  const CpuWidget({super.key});

  @override
  State<CpuWidget> createState() => _CpuWidgetState();
}

class _CpuWidgetState extends State<CpuWidget> {
  Timer? _timer;
  double _usage = 0.35;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() => _usage = 0.1 + Random().nextDouble() * 0.6);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  value: _usage,
                  strokeWidth: 4,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                ),
              ),
              Text('${(_usage * 100).toInt()}%', style: const TextStyle(fontSize: 10)),
            ],
          ),
          const SizedBox(height: 2),
          const Text('CPU', style: TextStyle(fontSize: 9)),
        ],
      ),
    );
  }
}

class MemoryWidget extends StatelessWidget {
  const MemoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.storage, size: 24),
          SizedBox(height: 2),
          Text('4.2/8G', style: TextStyle(fontSize: 9)),
        ],
      ),
    );
  }
}

class NetworkWidget extends StatefulWidget {
  const NetworkWidget({super.key});

  @override
  State<NetworkWidget> createState() => _NetworkWidgetState();
}

class _NetworkWidgetState extends State<NetworkWidget> {
  String _status = 'WiFi';

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _status = result == ConnectivityResult.wifi ? 'WiFi' :
                 result == ConnectivityResult.mobile ? '5G' : '离线';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_status == '离线' ? Icons.signal_wifi_off : Icons.wifi, size: 24),
          const SizedBox(height: 2),
          Text(_status, style: const TextStyle(fontSize: 9)),
        ],
      ),
    );
  }
}

class StorageWidget extends StatelessWidget {
  const StorageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.sd_storage, size: 24),
          SizedBox(height: 2),
          Text('64/128G', style: TextStyle(fontSize: 9)),
        ],
      ),
    );
  }
}

class StepsWidget extends StatelessWidget {
  const StepsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_walk, size: 24),
          SizedBox(height: 2),
          Text('8,432', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class MoonPhaseWidget extends StatelessWidget {
  const MoonPhaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.nightlight_round, size: 28),
          SizedBox(height: 2),
          Text('满月', style: TextStyle(fontSize: 9)),
        ],
      ),
    );
  }
}

class SunriseWidget extends StatelessWidget {
  const SunriseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.wb_twilight, size: 16),
                  Text('06:12', style: TextStyle(fontSize: 9)),
                ],
              ),
              Column(
                children: [
                  Icon(Icons.wb_sunny, size: 16),
                  Text('18:45', style: TextStyle(fontSize: 9)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StocksWidget extends StatelessWidget {
  const StocksWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('AAPL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              Text('+1.2%', style: TextStyle(fontSize: 11, color: Colors.green)),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            height: 20,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green.withOpacity(0.3), Colors.green.withOpacity(0.1)],
              ),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

class TodoWidget extends StatefulWidget {
  const TodoWidget({super.key});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  final List<Map<String, dynamic>> _todos = [
    {'text': '完成设计稿', 'done': true},
    {'text': '代码审查', 'done': false},
    {'text': '发布版本', 'done': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.check_circle_outline, size: 14),
              SizedBox(width: 4),
              Text('待办', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          ..._todos.take(3).map((t) => Row(
            children: [
              Icon(
                t['done'] ? Icons.check_circle : Icons.circle_outlined,
                size: 12,
                color: t['done'] ? Colors.green : null,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  t['text'],
                  style: TextStyle(
                    fontSize: 10,
                    decoration: t['done'] ? TextDecoration.lineThrough : null,
                    color: t['done'] ? Colors.grey : null,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class RssWidget extends StatelessWidget {
  const RssWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Row(
            children: [
              Icon(Icons.rss_feed, size: 14),
              SizedBox(width: 4),
              Text('资讯', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          Text('Flutter 3.19 发布...', style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8))),
          Text('Android 15 新特性...', style: TextStyle(fontSize: 10, color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6))),
        ],
      ),
    );
  }
}

class SocialWidget extends StatelessWidget {
  const SocialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.chat_bubble_outline, size: 20),
          Icon(Icons.favorite_border, size: 20),
          Icon(Icons.share, size: 20),
        ],
      ),
    );
  }
}

class SystemInfoWidget extends StatelessWidget {
  const SystemInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('ChumianOS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary)),
          const Text('v1.0.0', style: TextStyle(fontSize: 9)),
          const Text('Android 14', style: TextStyle(fontSize: 9)),
          const Text('Kernel 5.15', style: TextStyle(fontSize: 9)),
        ],
      ),
    );
  }
}

class FlashlightWidget extends StatefulWidget {
  const FlashlightWidget({super.key});

  @override
  State<FlashlightWidget> createState() => _FlashlightWidgetState();
}

class _FlashlightWidgetState extends State<FlashlightWidget> {
  bool _on = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _on = !_on),
      child: Center(
        child: Icon(
          _on ? Icons.flashlight_on : Icons.flashlight_off,
          size: 28,
          color: _on ? Colors.yellow : null,
        ),
      ),
    );
  }
}

class CalculatorWidget extends StatefulWidget {
  const CalculatorWidget({super.key});

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  String _display = '0';

  void _press(String key) {
    setState(() {
      if (_display == '0') _display = key;
      else _display += key;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(_display, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 1.5,
              physics: const NeverScrollableScrollPhysics(),
              children: ['7','8','9','/','4','5','6','*','1','2','3','-','0','.','=','+'].map((k) => 
                GestureDetector(
                  onTap: () => _press(k),
                  child: Container(
                    margin: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(child: Text(k, style: const TextStyle(fontSize: 10))),
                  ),
                ),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class CompassWidget extends StatefulWidget {
  const CompassWidget({super.key});

  @override
  State<CompassWidget> createState() => _CompassWidgetState();
}

class _CompassWidgetState extends State<CompassWidget> {
  double _angle = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: _angle * pi / 180,
        child: const Icon(Icons.explore, size: 36),
      ),
    );
  }
}

class LevelWidget extends StatelessWidget {
  const LevelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.straighten, size: 28),
          SizedBox(height: 4),
          Text('0.0°', style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class RulerWidget extends StatelessWidget {
  const RulerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: List.generate(20, (i) => Container(
          width: 4,
          height: i % 5 == 0 ? 20 : 10,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
        )),
      ),
    );
  }
}

class SoundWidget extends StatefulWidget {
  const SoundWidget({super.key});

  @override
  State<SoundWidget> createState() => _SoundWidgetState();
}

class _SoundWidgetState extends State<SoundWidget> {
  double _volume = 0.5;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(_volume > 0 ? Icons.volume_up : Icons.volume_off, size: 20),
          Slider(
            value: _volume,
            onChanged: (v) => setState(() => _volume = v),
            min: 0,
            max: 1,
          ),
        ],
      ),
    );
  }
}

class BrightnessWidget extends StatefulWidget {
  const BrightnessWidget({super.key});

  @override
  State<BrightnessWidget> createState() => _BrightnessWidgetState();
}

class _BrightnessWidgetState extends State<BrightnessWidget> {
  double _brightness = 0.7;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.brightness_6, size: 20),
          Slider(
            value: _brightness,
            onChanged: (v) => setState(() => _brightness = v),
            min: 0,
            max: 1,
          ),
        ],
      ),
    );
  }
}

class WifiToggleWidget extends StatefulWidget {
  const WifiToggleWidget({super.key});

  @override
  State<WifiToggleWidget> createState() => _WifiToggleWidgetState();
}

class _WifiToggleWidgetState extends State<WifiToggleWidget> {
  bool _on = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _on = !_on),
      child: Center(
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _on ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.surfaceVariant,
            shape: BoxShape.circle,
          ),
          child: Icon(
            _on ? Icons.wifi : Icons.wifi_off,
            size: 22,
            color: _on ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}

class BluetoothToggleWidget extends StatefulWidget {
  const BluetoothToggleWidget({super.key});

  @override
  State<BluetoothToggleWidget> createState() => _BluetoothToggleWidgetState();
}

class _BluetoothToggleWidgetState extends State<BluetoothToggleWidget> {
  bool _on = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _on = !_on),
      child: Center(
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _on ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.surfaceVariant,
            shape: BoxShape.circle,
          ),
          child: Icon(
            _on ? Icons.bluetooth : Icons.bluetooth_disabled,
            size: 22,
            color: _on ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}

class AirplaneToggleWidget extends StatefulWidget {
  const AirplaneToggleWidget({super.key});

  @override
  State<AirplaneToggleWidget> createState() => _AirplaneToggleWidgetState();
}

class _AirplaneToggleWidgetState extends State<AirplaneToggleWidget> {
  bool _on = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _on = !_on),
      child: Center(
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _on ? Colors.orange.withOpacity(0.3) : Theme.of(context).colorScheme.surfaceVariant,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.airplanemode_active,
            size: 22,
            color: _on ? Colors.orange : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}
