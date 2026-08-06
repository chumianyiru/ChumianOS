import 'package:flutter/material.dart';
import '../providers/widget_provider.dart';
import 'clock_widgets.dart';
import 'system_widgets.dart';

class DesktopWidgetContainer extends StatelessWidget {
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
  Widget build(BuildContext context) {
    Widget content;
    switch (widget.type) {
      case 'clock_analog':
        content = const AnalogClockWidget();
        break;
      case 'clock_digital':
        content = const DigitalClockWidget();
        break;
      case 'clock_flip':
        content = const FlipClockWidget();
        break;
      case 'weather':
        content = const WeatherWidget();
        break;
      case 'calendar':
        content = const CalendarWidget();
        break;
      case 'battery':
        content = const BatteryWidget();
        break;
      case 'music':
        content = const MusicWidget();
        break;
      case 'search':
        content = const SearchWidget();
        break;
      case 'notes':
        content = const NotesWidget();
        break;
      case 'photos':
        content = const PhotosWidget();
        break;
      case 'cpu':
        content = const CpuWidget();
        break;
      case 'memory':
        content = const MemoryWidget();
        break;
      case 'network':
        content = const NetworkWidget();
        break;
      case 'storage':
        content = const StorageWidget();
        break;
      case 'steps':
        content = const StepsWidget();
        break;
      case 'timer':
        content = const TimerWidget();
        break;
      case 'alarm':
        content = const AlarmWidget();
        break;
      case 'world_clock':
        content = const WorldClockWidget();
        break;
      case 'moon_phase':
        content = const MoonPhaseWidget();
        break;
      case 'sunrise':
        content = const SunriseWidget();
        break;
      case 'stocks':
        content = const StocksWidget();
        break;
      case 'todo':
        content = const TodoWidget();
        break;
      case 'rss':
        content = const RssWidget();
        break;
      case 'twitter':
        content = const SocialWidget();
        break;
      case 'system_info':
        content = const SystemInfoWidget();
        break;
      case 'flashlight':
        content = const FlashlightWidget();
        break;
      case 'calculator':
        content = const CalculatorWidget();
        break;
      case 'compass':
        content = const CompassWidget();
        break;
      case 'level':
        content = const LevelWidget();
        break;
      case 'ruler':
        content = const RulerWidget();
        break;
      case 'sound':
        content = const SoundWidget();
        break;
      case 'brightness':
        content = const BrightnessWidget();
        break;
      case 'wifi_toggle':
        content = const WifiToggleWidget();
        break;
      case 'bluetooth_toggle':
        content = const BluetoothToggleWidget();
        break;
      case 'airplane_toggle':
        content = const AirplaneToggleWidget();
        break;
      default:
        content = const UnknownWidget();
    }

    return Positioned(
      left: widget.x * 90.0,
      top: widget.y * 90.0 + 60,
      child: GestureDetector(
        onLongPress: isEditMode ? null : () {},
        child: Container(
          width: widget.width * 90.0 - 8,
          height: widget.height * 90.0 - 8,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
            borderRadius: BorderRadius.circular(24),
            border: isEditMode
                ? Border.all(color: Theme.of(context).colorScheme.primary, width: 2)
                : null,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
                content,
                if (isEditMode)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: onRemove,
                      child: Container(
                        width: 24,
                        height: 24,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 14, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UnknownWidget extends StatelessWidget {
  const UnknownWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Icon(Icons.widgets, size: 32));
  }
}
