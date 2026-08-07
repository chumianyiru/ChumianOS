import 'package:flutter/material.dart';
import '../theme.dart';

class AboutScreen extends StatelessWidget {
  final VoidCallback onDevClick;
  final bool developerMode;

  const AboutScreen({
    super.key,
    required this.onDevClick,
    required this.developerMode,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ChumianTheme.pinkGradientBox,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_back, color: ChumianTheme.textDark),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      '关于手机',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: ChumianTheme.textDark,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: ChumianTheme.primaryPink,
                          shape: BoxShape.circle,
                          boxShadow: ChumianTheme.softShadow,
                        ),
                        child: Icon(Icons.android, color: Colors.white, size: 50),
                      ),
                    ),
                    SizedBox(height: 16),
                    Center(
                      child: Text(
                        'ChumianOS',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: ChumianTheme.textDark,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Center(
                      child: Text(
                        '版本 1.0.0',
                        style: TextStyle(
                          fontSize: 14,
                          color: ChumianTheme.textDark.withOpacity(0.6),
                        ),
                      ),
                    ),
                    SizedBox(height: 32),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          _AboutItem(title: '设备名称', value: 'Chumian Phone'),
                          _AboutItem(title: '型号', value: 'CM-001'),
                          _AboutItem(title: '系统版本', value: 'ChumianOS 1.0'),
                          _AboutItem(title: 'Android 版本', value: '13'),
                          _AboutItem(title: '内核版本', value: '5.15.0-chumian'),
                          _AboutItem(title: '构建号', value: 'CM1.0-20260807'),
                          GestureDetector(
                            onTap: onDevClick,
                            child: _AboutItem(
                              title: '版本号',
                              value: 'CM1.0.0-20260807',
                              isClickable: true,
                            ),
                          ),
                          if (developerMode)
                            _AboutItem(
                              title: '开发者模式',
                              value: '已开启',
                              valueColor: Colors.green,
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Powered by Chumian Team',
                        style: TextStyle(
                          fontSize: 12,
                          color: ChumianTheme.textDark.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isClickable;
  final Color? valueColor;

  const _AboutItem({
    required this.title,
    required this.value,
    this.isClickable = false,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: ChumianTheme.textDark,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 15,
              color: valueColor ?? ChumianTheme.textDark.withOpacity(0.6),
              fontWeight: isClickable ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
