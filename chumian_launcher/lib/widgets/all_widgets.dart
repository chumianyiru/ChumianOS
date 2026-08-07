import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme.dart';

class ClockWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat('HH:mm').format(DateTime.now()),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w200,
                  color: ChumianTheme.textDark,
                ),
              ),
              Text(
                DateFormat('EEEE, MMMM d日', 'zh_CN').format(DateTime.now()),
                style: TextStyle(
                  fontSize: 14,
                  color: ChumianTheme.textDark.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: ChumianTheme.primaryPink.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.access_time, color: ChumianTheme.primaryPink, size: 30),
          ),
        ],
      ),
    );
  }
}

class WeatherWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '26°C',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w300,
                  color: ChumianTheme.textDark,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '晴 · 六安',
                style: TextStyle(
                  fontSize: 14,
                  color: ChumianTheme.textDark.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Icon(Icons.wb_sunny, color: Colors.orange, size: 50),
        ],
      ),
    );
  }
}

class MusicWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: ChumianTheme.primaryPink,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.music_note, color: Colors.white, size: 28),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '正在播放',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ChumianTheme.textDark,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Chumian Music',
                  style: TextStyle(
                    fontSize: 12,
                    color: ChumianTheme.textDark.withOpacity(0.6),
                  ),
                ),
                SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.4,
                    backgroundColor: ChumianTheme.lightPink.withOpacity(0.3),
                    valueColor: AlwaysStoppedAnimation(ChumianTheme.primaryPink),
                    minHeight: 4,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: ChumianTheme.primaryPink,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.play_arrow, color: Colors.white, size: 24),
          ),
        ],
      ),
    );
  }
}

class CalendarWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${now.month}月',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ChumianTheme.primaryPink,
                ),
              ),
              Text(
                '${now.day}',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.w300,
                  color: ChumianTheme.textDark,
                ),
              ),
              Text(
                '今日 3 个日程',
                style: TextStyle(
                  fontSize: 12,
                  color: ChumianTheme.textDark.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: ChumianTheme.primaryPink.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.calendar_today, color: ChumianTheme.primaryPink, size: 28),
          ),
        ],
      ),
    );
  }
}

class StepsWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '6,842',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w300,
                  color: ChumianTheme.textDark,
                ),
              ),
              Text(
                '今日步数 · 目标 10000',
                style: TextStyle(
                  fontSize: 12,
                  color: ChumianTheme.textDark.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: 0.68,
                  strokeWidth: 6,
                  backgroundColor: ChumianTheme.lightPink.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation(ChumianTheme.primaryPink),
                ),
              ),
              Icon(Icons.directions_walk, color: ChumianTheme.primaryPink, size: 24),
            ],
          ),
        ],
      ),
    );
  }
}

class BatteryWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '85%',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w300,
                  color: ChumianTheme.textDark,
                ),
              ),
              Text(
                '剩余约 8 小时',
                style: TextStyle(
                  fontSize: 12,
                  color: ChumianTheme.textDark.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: 0.85,
                  strokeWidth: 6,
                  backgroundColor: ChumianTheme.lightPink.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation(Colors.green),
                ),
              ),
              Icon(Icons.battery_full, color: Colors.green, size: 24),
            ],
          ),
        ],
      ),
    );
  }
}

class ShortcutsWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ShortcutIcon(icon: Icons.camera_alt, color: Color(0xFFBA68C8)),
          _ShortcutIcon(icon: Icons.phone, color: Color(0xFF81C784)),
          _ShortcutIcon(icon: Icons.message, color: Color(0xFF64B5F6)),
          _ShortcutIcon(icon: Icons.music_note, color: Color(0xFFE57373)),
        ],
      ),
    );
  }
}

class _ShortcutIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _ShortcutIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}

class SearchWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: ChumianTheme.primaryPink),
          SizedBox(width: 12),
          Text(
            '搜索应用、联系人、网页...',
            style: TextStyle(
              color: ChumianTheme.textDark.withOpacity(0.5),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class PhotosWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '最近照片',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ChumianTheme.textDark,
                ),
              ),
              Text(
                '查看全部',
                style: TextStyle(
                  fontSize: 12,
                  color: ChumianTheme.primaryPink,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _PhotoItem(color: Color(0xFFFFB74D))),
              SizedBox(width: 8),
              Expanded(child: _PhotoItem(color: Color(0xFF81C784))),
              SizedBox(width: 8),
              Expanded(child: _PhotoItem(color: Color(0xFF64B5F6))),
              SizedBox(width: 8),
              Expanded(child: _PhotoItem(color: Color(0xFFBA68C8))),
            ],
          ),
        ],
      ),
    );
  }
}

class _PhotoItem extends StatelessWidget {
  final Color color;
  const _PhotoItem({required this.color});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

class RemindersWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '提醒事项',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ChumianTheme.textDark,
                ),
              ),
              Text(
                '3 项',
                style: TextStyle(
                  fontSize: 12,
                  color: ChumianTheme.primaryPink,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          _ReminderItem(text: '下午3点 项目会议', done: false),
          SizedBox(height: 8),
          _ReminderItem(text: '晚上7点 健身', done: false),
          SizedBox(height: 8),
          _ReminderItem(text: '回复邮件', done: true),
        ],
      ),
    );
  }
}

class _ReminderItem extends StatelessWidget {
  final String text;
  final bool done;
  const _ReminderItem({required this.text, required this.done});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: done ? ChumianTheme.primaryPink : Colors.transparent,
            border: Border.all(color: ChumianTheme.primaryPink, width: 2),
            shape: BoxShape.circle,
          ),
          child: done
              ? Icon(Icons.check, color: Colors.white, size: 14)
              : null,
        ),
        SizedBox(width: 12),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: done
                ? ChumianTheme.textDark.withOpacity(0.4)
                : ChumianTheme.textDark,
            decoration: done ? TextDecoration.lineThrough : null,
          ),
        ),
      ],
    );
  }
}

class HealthWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '健康数据',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ChumianTheme.textDark,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _HealthItem(icon: Icons.favorite, label: '心率', value: '72', unit: 'bpm'),
              _HealthItem(icon: Icons.local_fire_department, label: '卡路里', value: '320', unit: 'kcal'),
              _HealthItem(icon: Icons.bedtime, label: '睡眠', value: '7.5', unit: '小时'),
            ],
          ),
        ],
      ),
    );
  }
}

class _HealthItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  const _HealthItem({required this.icon, required this.label, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: ChumianTheme.primaryPink.withOpacity(0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: ChumianTheme.primaryPink, size: 20),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ChumianTheme.textDark,
          ),
        ),
        Text(
          '$label $unit',
          style: TextStyle(
            fontSize: 10,
            color: ChumianTheme.textDark.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}

class NewsWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '今日头条',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ChumianTheme.textDark,
                ),
              ),
              Icon(Icons.chevron_right, color: ChumianTheme.primaryPink),
            ],
          ),
          SizedBox(height: 12),
          Text(
            '• Flutter 3.44 正式发布，性能大幅提升',
            style: TextStyle(fontSize: 13, color: ChumianTheme.textDark),
          ),
          SizedBox(height: 6),
          Text(
            '• AI 大模型技术取得新突破',
            style: TextStyle(fontSize: 13, color: ChumianTheme.textDark),
          ),
          SizedBox(height: 6),
          Text(
            '• 国产操作系统迎来发展新机遇',
            style: TextStyle(fontSize: 13, color: ChumianTheme.textDark),
          ),
        ],
      ),
    );
  }
}

class StockWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '自选股',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ChumianTheme.textDark,
                ),
              ),
              Text(
                '+2.35%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StockItem(name: '茅台', price: '1680', change: '+1.2%'),
              _StockItem(name: '腾讯', price: '385', change: '+2.5%'),
              _StockItem(name: '苹果', price: '195', change: '+0.8%'),
            ],
          ),
        ],
      ),
    );
  }
}

class _StockItem extends StatelessWidget {
  final String name;
  final String price;
  final String change;
  const _StockItem({required this.name, required this.price, required this.change});

  @override
  Widget build(BuildContext context) {
    final isUp = change.startsWith('+');
    return Column(
      children: [
        Text(
          name,
          style: TextStyle(fontSize: 12, color: ChumianTheme.textDark.withOpacity(0.6)),
        ),
        SizedBox(height: 4),
        Text(
          price,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ChumianTheme.textDark,
          ),
        ),
        Text(
          change,
          style: TextStyle(
            fontSize: 11,
            color: isUp ? Colors.red : Colors.green,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class TodoWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '待办清单',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ChumianTheme.textDark,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: ChumianTheme.primaryPink.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '2/5',
                  style: TextStyle(
                    fontSize: 11,
                    color: ChumianTheme.primaryPink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          LinearProgressIndicator(
            value: 0.4,
            backgroundColor: ChumianTheme.lightPink.withOpacity(0.3),
            valueColor: AlwaysStoppedAnimation(ChumianTheme.primaryPink),
            minHeight: 6,
            borderRadius: BorderRadius.circular(3),
          ),
          SizedBox(height: 12),
          _TodoItem(text: '完成项目文档', done: true),
          SizedBox(height: 8),
          _TodoItem(text: '代码审查', done: true),
          SizedBox(height: 8),
          _TodoItem(text: '部署测试环境', done: false),
        ],
      ),
    );
  }
}

class _TodoItem extends StatelessWidget {
  final String text;
  final bool done;
  const _TodoItem({required this.text, required this.done});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: done ? ChumianTheme.primaryPink : Colors.transparent,
            border: Border.all(color: ChumianTheme.primaryPink, width: 2),
            shape: BoxShape.circle,
          ),
          child: done ? Icon(Icons.check, color: Colors.white, size: 12) : null,
        ),
        SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: done ? ChumianTheme.textDark.withOpacity(0.4) : ChumianTheme.textDark,
            decoration: done ? TextDecoration.lineThrough : null,
          ),
        ),
      ],
    );
  }
}

class WorldClockWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '世界时钟',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: ChumianTheme.textDark,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _WorldClockItem(city: '北京', time: '15:30', zone: 'GMT+8'),
              _WorldClockItem(city: '东京', time: '16:30', zone: 'GMT+9'),
              _WorldClockItem(city: '纽约', time: '02:30', zone: 'GMT-5'),
              _WorldClockItem(city: '伦敦', time: '07:30', zone: 'GMT+0'),
            ],
          ),
        ],
      ),
    );
  }
}

class _WorldClockItem extends StatelessWidget {
  final String city;
  final String time;
  final String zone;
  const _WorldClockItem({required this.city, required this.time, required this.zone});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          city,
          style: TextStyle(fontSize: 11, color: ChumianTheme.textDark.withOpacity(0.6)),
        ),
        SizedBox(height: 4),
        Text(
          time,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ChumianTheme.textDark,
          ),
        ),
        Text(
          zone,
          style: TextStyle(fontSize: 10, color: ChumianTheme.textDark.withOpacity(0.5)),
        ),
      ],
    );
  }
}

class NotesWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '备忘录',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ChumianTheme.textDark,
                ),
              ),
              Icon(Icons.add, color: ChumianTheme.primaryPink, size: 20),
            ],
          ),
          SizedBox(height: 12),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Color(0xFFFFF9C4),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '记得买牛奶和面包\n周末要去健身房',
              style: TextStyle(fontSize: 12, color: Colors.brown[800]),
            ),
          ),
        ],
      ),
    );
  }
}

class RecorderWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.mic, color: Colors.red, size: 24),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '录音中',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ChumianTheme.textDark,
                    ),
                  ),
                  Text(
                    '00:02:35',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: ChumianTheme.primaryPink.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.pause, color: ChumianTheme.primaryPink, size: 20),
              ),
              SizedBox(width: 8),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.stop, color: Colors.red, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CalculatorWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            '128',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w300,
              color: ChumianTheme.textDark,
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _CalcButton(text: '7'),
              _CalcButton(text: '8'),
              _CalcButton(text: '9'),
              _CalcButton(text: '÷', isOp: true),
            ],
          ),
        ],
      ),
    );
  }
}

class _CalcButton extends StatelessWidget {
  final String text;
  final bool isOp;
  const _CalcButton({required this.text, this.isOp = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isOp ? ChumianTheme.primaryPink : ChumianTheme.lightPink.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isOp ? Colors.white : ChumianTheme.textDark,
          ),
        ),
      ),
    );
  }
}

class CompassWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'N 35°',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w300,
                  color: ChumianTheme.textDark,
                ),
              ),
              Text(
                '东北方向',
                style: TextStyle(
                  fontSize: 12,
                  color: ChumianTheme.textDark.withOpacity(0.6),
                ),
              ),
            ],
          ),
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: ChumianTheme.primaryPink.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Transform.rotate(
              angle: 0.6,
              child: Icon(Icons.explore, color: ChumianTheme.primaryPink, size: 36),
            ),
          ),
        ],
      ),
    );
  }
}

class FlashlightWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.flash_on, color: Colors.orange, size: 24),
              ),
              SizedBox(width: 12),
              Text(
                '手电筒',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: ChumianTheme.textDark,
                ),
              ),
            ],
          ),
          Switch(value: false, onChanged: (_) {}),
        ],
      ),
    );
  }
}

class VolumeWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.volume_up, color: ChumianTheme.primaryPink, size: 20),
              SizedBox(width: 8),
              Text(
                '音量',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ChumianTheme.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Slider(
            value: 0.7,
            onChanged: (_) {},
            activeColor: ChumianTheme.primaryPink,
            inactiveColor: ChumianTheme.lightPink.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}

class BrightnessWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.brightness_6, color: ChumianTheme.primaryPink, size: 20),
              SizedBox(width: 8),
              Text(
                '亮度',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: ChumianTheme.textDark,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Slider(
            value: 0.6,
            onChanged: (_) {},
            activeColor: ChumianTheme.primaryPink,
            inactiveColor: ChumianTheme.lightPink.withOpacity(0.3),
          ),
        ],
      ),
    );
  }
}

class WifiWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _QuickToggleCard(
      icon: Icons.wifi,
      label: 'WiFi',
      subtitle: 'Chumian_5G',
      color: Colors.blue,
      value: true,
    );
  }
}

class BluetoothWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _QuickToggleCard(
      icon: Icons.bluetooth,
      label: '蓝牙',
      subtitle: '已连接 2 台设备',
      color: Colors.blue,
      value: true,
    );
  }
}

class AirplaneWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _QuickToggleCard(
      icon: Icons.flight,
      label: '飞行模式',
      subtitle: '关闭',
      color: Colors.grey,
      value: false,
    );
  }
}

class LocationWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _QuickToggleCard(
      icon: Icons.location_on,
      label: '定位',
      subtitle: '高精度',
      color: Colors.green,
      value: true,
    );
  }
}

class RotationWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _QuickToggleCard(
      icon: Icons.screen_rotation,
      label: '自动旋转',
      subtitle: '已开启',
      color: Colors.teal,
      value: true,
    );
  }
}

class BatterySaverWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _QuickToggleCard(
      icon: Icons.battery_saver,
      label: '省电模式',
      subtitle: '关闭',
      color: Colors.orange,
      value: false,
    );
  }
}

class NfcWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _QuickToggleCard(
      icon: Icons.nfc,
      label: 'NFC',
      subtitle: '已开启',
      color: Colors.indigo,
      value: true,
    );
  }
}

class HotspotWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _QuickToggleCard(
      icon: Icons.wifi_tethering,
      label: '热点',
      subtitle: '关闭',
      color: Colors.orange,
      value: false,
    );
  }
}

class DataWidgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _QuickToggleCard(
      icon: Icons.signal_cellular_alt,
      label: '移动数据',
      subtitle: '4G',
      color: Colors.green,
      value: true,
    );
  }
}

class _QuickToggleCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color color;
  final bool value;

  const _QuickToggleCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.color,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ChumianTheme.cardPink,
        borderRadius: BorderRadius.circular(24),
        boxShadow: ChumianTheme.softShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: (value ? color : Colors.grey).withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: value ? color : Colors.grey, size: 24),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ChumianTheme.textDark,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      color: ChumianTheme.textDark.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Switch(value: value, onChanged: (_) {}),
        ],
      ),
    );
  }
}
