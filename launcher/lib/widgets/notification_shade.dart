import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationShade extends StatelessWidget {
  final VoidCallback onClose;
  final String currentTime;

  const NotificationShade({
    super.key,
    required this.onClose,
    required this.currentTime,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity != null && details.primaryVelocity! > 500) {
            onClose();
          }
        },
        onTap: onClose,
        child: Container(
          color: Colors.black54,
          child: GestureDetector(
            onTap: () {},
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.pink.shade100,
                      Colors.pink.shade50,
                    ],
                  ),
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 4,
                          decoration: BoxDecoration(
                            color: Colors.pink.shade300,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              currentTime,
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w200,
                                color: Colors.pink.shade700,
                              ),
                            ),
                            Text(
                              DateFormat('MM月dd日 EEEE', 'zh_CN').format(DateTime.now()),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.pink.shade400,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildQuickSettings(),
                        const SizedBox(height: 16),
                        _buildBrightnessSlider(),
                        const SizedBox(height: 16),
                        _buildVolumeSlider(),
                        const SizedBox(height: 16),
                        _buildNotificationsList(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuickSettings() {
    final toggles = [
      {'icon': Icons.wifi, 'label': 'WiFi', 'active': true},
      {'icon': Icons.bluetooth, 'label': '蓝牙', 'active': false},
      {'icon': Icons.flashlight_on, 'label': '手电筒', 'active': false},
      {'icon': Icons.airplanemode_active, 'label': '飞行', 'active': false},
      {'icon': Icons.brightness_6, 'label': '自动亮度', 'active': true},
      {'icon': Icons.volume_up, 'label': '铃声', 'active': true},
    ];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: GridView.count(
        crossAxisCount: 6,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.9,
        children: toggles.map((t) {
          final active = t['active'] as bool;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: active ? Colors.pink.shade400 : Colors.pink.shade100,
                ),
                child: Icon(
                  t['icon'] as IconData,
                  size: 18,
                  color: active ? Colors.white : Colors.pink.shade400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                t['label'] as String,
                style: TextStyle(fontSize: 9, color: Colors.pink.shade600),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBrightnessSlider() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.brightness_low, size: 20, color: Colors.pink.shade400),
          Expanded(
            child: Slider(
              value: 0.7,
              activeColor: Colors.pink.shade400,
              inactiveColor: Colors.pink.shade100,
              onChanged: (_) {},
            ),
          ),
          Icon(Icons.brightness_high, size: 20, color: Colors.pink.shade400),
        ],
      ),
    );
  }

  Widget _buildVolumeSlider() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(Icons.volume_down, size: 20, color: Colors.pink.shade400),
          Expanded(
            child: Slider(
              value: 0.6,
              activeColor: Colors.pink.shade400,
              inactiveColor: Colors.pink.shade100,
              onChanged: (_) {},
            ),
          ),
          Icon(Icons.volume_up, size: 20, color: Colors.pink.shade400),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    final notifications = [
      {'app': '微信', 'title': '新消息', 'content': '你有3条未读消息', 'time': '刚刚'},
      {'app': '系统', 'title': 'ChumianOS', 'content': '欢迎使用 ChumianOS 桌面启动器', 'time': '5分钟前'},
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text('通知', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.pink.shade700)),
        ),
        ...notifications.map((n) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pink.shade200,
                ),
                child: Icon(Icons.notifications, size: 16, color: Colors.pink.shade600),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(n['app'] as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.pink.shade700)),
                        Text(n['time'] as String, style: TextStyle(fontSize: 11, color: Colors.pink.shade400)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(n['title'] as String, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                    Text(n['content'] as String, style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                  ],
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}
