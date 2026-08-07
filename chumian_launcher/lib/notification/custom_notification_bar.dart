import 'package:flutter/material.dart';
import '../theme.dart';

class CustomNotificationBar extends StatefulWidget {
  final VoidCallback onClose;

  const CustomNotificationBar({super.key, required this.onClose});

  @override
  State<CustomNotificationBar> createState() => _CustomNotificationBarState();
}

class _CustomNotificationBarState extends State<CustomNotificationBar> {
  bool _wifi = true;
  bool _bluetooth = true;
  bool _mobileData = true;
  bool _airplane = false;
  bool _flashlight = false;
  bool _rotation = true;
  bool _location = true;
  bool _nfc = true;
  double _brightness = 0.6;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ChumianTheme.primaryPink.withOpacity(0.95),
            ChumianTheme.lightPink.withOpacity(0.9),
          ],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _getTime(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_4_bar, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Icon(Icons.wifi, color: Colors.white, size: 18),
                      SizedBox(width: 8),
                      Icon(Icons.battery_full, color: Colors.white, size: 18),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _QuickToggle(
                    icon: Icons.wifi,
                    label: 'WiFi',
                    active: _wifi,
                    onTap: () => setState(() => _wifi = !_wifi),
                  ),
                  _QuickToggle(
                    icon: Icons.bluetooth,
                    label: '蓝牙',
                    active: _bluetooth,
                    onTap: () => setState(() => _bluetooth = !_bluetooth),
                  ),
                  _QuickToggle(
                    icon: Icons.signal_cellular_alt,
                    label: '数据',
                    active: _mobileData,
                    onTap: () => setState(() => _mobileData = !_mobileData),
                  ),
                  _QuickToggle(
                    icon: Icons.flight,
                    label: '飞行',
                    active: _airplane,
                    onTap: () => setState(() => _airplane = !_airplane),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _QuickToggle(
                    icon: Icons.flash_on,
                    label: '手电',
                    active: _flashlight,
                    onTap: () => setState(() => _flashlight = !_flashlight),
                  ),
                  _QuickToggle(
                    icon: Icons.screen_rotation,
                    label: '旋转',
                    active: _rotation,
                    onTap: () => setState(() => _rotation = !_rotation),
                  ),
                  _QuickToggle(
                    icon: Icons.location_on,
                    label: '定位',
                    active: _location,
                    onTap: () => setState(() => _location = !_location),
                  ),
                  _QuickToggle(
                    icon: Icons.nfc,
                    label: 'NFC',
                    active: _nfc,
                    onTap: () => setState(() => _nfc = !_nfc),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.brightness_6, color: Colors.white, size: 20),
                  SizedBox(width: 12),
                  Expanded(
                    child: Slider(
                      value: _brightness,
                      onChanged: (v) => setState(() => _brightness = v),
                      activeColor: Colors.white,
                      inactiveColor: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: widget.onClose,
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTime() {
    final now = DateTime.now();
    return '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';
  }
}

class _QuickToggle extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _QuickToggle({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: active ? Colors.white.withOpacity(0.3) : Colors.white.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: active ? Colors.white : Colors.white.withOpacity(0.6),
              size: 26,
            ),
          ),
          SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
