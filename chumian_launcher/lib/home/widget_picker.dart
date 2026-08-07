import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/all_widgets.dart';

class WidgetPickerSheet extends StatelessWidget {
  final Function(Widget) onWidgetSelected;

  const WidgetPickerSheet({super.key, required this.onWidgetSelected});

  final List<Map<String, dynamic>> _widgets = const [
    {'name': '时钟', 'icon': Icons.access_time, 'builder': _buildClock},
    {'name': '天气', 'icon': Icons.wb_sunny, 'builder': _buildWeather},
    {'name': '音乐', 'icon': Icons.music_note, 'builder': _buildMusic},
    {'name': '日历', 'icon': Icons.calendar_today, 'builder': _buildCalendar},
    {'name': '步数', 'icon': Icons.directions_walk, 'builder': _buildSteps},
    {'name': '电池', 'icon': Icons.battery_full, 'builder': _buildBattery},
    {'name': '快捷方式', 'icon': Icons.apps, 'builder': _buildShortcuts},
    {'name': '搜索', 'icon': Icons.search, 'builder': _buildSearch},
    {'name': '相册', 'icon': Icons.photo_library, 'builder': _buildPhotos},
    {'name': '提醒', 'icon': Icons.notifications, 'builder': _buildReminders},
    {'name': '健康', 'icon': Icons.favorite, 'builder': _buildHealth},
    {'name': '新闻', 'icon': Icons.article, 'builder': _buildNews},
    {'name': '股票', 'icon': Icons.show_chart, 'builder': _buildStock},
    {'name': '待办', 'icon': Icons.check_circle, 'builder': _buildTodo},
    {'name': '世界时钟', 'icon': Icons.public, 'builder': _buildWorldClock},
    {'name': '备忘录', 'icon': Icons.note, 'builder': _buildNotes},
    {'name': '录音', 'icon': Icons.mic, 'builder': _buildRecorder},
    {'name': '计算器', 'icon': Icons.calculate, 'builder': _buildCalculator},
    {'name': '指南针', 'icon': Icons.explore, 'builder': _buildCompass},
    {'name': '手电筒', 'icon': Icons.flash_on, 'builder': _buildFlashlight},
    {'name': '音量', 'icon': Icons.volume_up, 'builder': _buildVolume},
    {'name': '亮度', 'icon': Icons.brightness_6, 'builder': _buildBrightness},
    {'name': 'WiFi', 'icon': Icons.wifi, 'builder': _buildWifi},
    {'name': '蓝牙', 'icon': Icons.bluetooth, 'builder': _buildBluetooth},
    {'name': '飞行模式', 'icon': Icons.flight, 'builder': _buildAirplane},
    {'name': '定位', 'icon': Icons.location_on, 'builder': _buildLocation},
    {'name': '旋转', 'icon': Icons.screen_rotation, 'builder': _buildRotation},
    {'name': '省电', 'icon': Icons.battery_saver, 'builder': _buildBatterySaver},
    {'name': 'NFC', 'icon': Icons.nfc, 'builder': _buildNfc},
    {'name': '热点', 'icon': Icons.wifi_tethering, 'builder': _buildHotspot},
    {'name': '数据', 'icon': Icons.signal_cellular_alt, 'builder': _buildData},
  ];

  static Widget _buildClock() => ClockWidgetCard();
  static Widget _buildWeather() => WeatherWidgetCard();
  static Widget _buildMusic() => MusicWidgetCard();
  static Widget _buildCalendar() => CalendarWidgetCard();
  static Widget _buildSteps() => StepsWidgetCard();
  static Widget _buildBattery() => BatteryWidgetCard();
  static Widget _buildShortcuts() => ShortcutsWidgetCard();
  static Widget _buildSearch() => SearchWidgetCard();
  static Widget _buildPhotos() => PhotosWidgetCard();
  static Widget _buildReminders() => RemindersWidgetCard();
  static Widget _buildHealth() => HealthWidgetCard();
  static Widget _buildNews() => NewsWidgetCard();
  static Widget _buildStock() => StockWidgetCard();
  static Widget _buildTodo() => TodoWidgetCard();
  static Widget _buildWorldClock() => WorldClockWidgetCard();
  static Widget _buildNotes() => NotesWidgetCard();
  static Widget _buildRecorder() => RecorderWidgetCard();
  static Widget _buildCalculator() => CalculatorWidgetCard();
  static Widget _buildCompass() => CompassWidgetCard();
  static Widget _buildFlashlight() => FlashlightWidgetCard();
  static Widget _buildVolume() => VolumeWidgetCard();
  static Widget _buildBrightness() => BrightnessWidgetCard();
  static Widget _buildWifi() => WifiWidgetCard();
  static Widget _buildBluetooth() => BluetoothWidgetCard();
  static Widget _buildAirplane() => AirplaneWidgetCard();
  static Widget _buildLocation() => LocationWidgetCard();
  static Widget _buildRotation() => RotationWidgetCard();
  static Widget _buildBatterySaver() => BatterySaverWidgetCard();
  static Widget _buildNfc() => NfcWidgetCard();
  static Widget _buildHotspot() => HotspotWidgetCard();
  static Widget _buildData() => DataWidgetCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: ChumianTheme.lightPink,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              '选择小组件',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: ChumianTheme.textDark,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: _widgets.length,
              itemBuilder: (context, index) {
                final w = _widgets[index];
                return GestureDetector(
                  onTap: () => onWidgetSelected(w['builder']()),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: ChumianTheme.primaryPink.withOpacity(0.15),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          w['icon'],
                          color: ChumianTheme.primaryPink,
                          size: 28,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        w['name'],
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
              },
            ),
          ),
        ],
      ),
    );
  }
}
