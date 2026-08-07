import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentStep = 0;
  final PageController _pageController = PageController();
  final TextEditingController _nameController = TextEditingController(text: '初眠用户');
  bool _agreed = false;
  bool _activating = false;

  final List<Map<String, dynamic>> _steps = [
    {
      'icon': Icons.favorite,
      'title': '欢迎使用',
      'subtitle': 'ChumianOS',
      'description': '全新的粉色系定制系统\n为你带来极致的个性化体验',
    },
    {
      'icon': Icons.palette,
      'title': '个性化定制',
      'subtitle': 'Material You 设计',
      'description': '圆形图标 · 粉色主题 · 30+小组件\n打造专属于你的桌面体验',
    },
    {
      'icon': Icons.security,
      'title': '系统配置',
      'subtitle': '基础设置',
      'description': '设置你的设备名称\n并确认用户协议',
    },
    {
      'icon': Icons.rocket_launch,
      'title': '激活完成',
      'subtitle': '开始使用',
      'description': '一切准备就绪\n点击激活按钮，开启你的ChumianOS之旅',
    },
  ];

  void _nextStep() {
    if (_currentStep < _steps.length - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      HapticFeedback.lightImpact();
    }
  }

  void _prevStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _activate() async {
    if (!_agreed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('请先同意用户协议')),
      );
      return;
    }

    setState(() {
      _activating = true;
    });

    HapticFeedback.mediumImpact();

    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _activating = false;
    });

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: ChumianTheme.cardPink,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Center(
          child: Column(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check, color: Colors.white, size: 36),
              ),
              SizedBox(height: 16),
              Text(
                '激活成功！',
                style: TextStyle(
                  color: ChumianTheme.textDark,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ChumianOS 已成功激活',
              textAlign: TextAlign.center,
              style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.7)),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.pink.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: ChumianTheme.primaryPink, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '无 Root 模式已启用\n核心功能均可正常使用',
                      style: TextStyle(
                        fontSize: 12,
                        color: ChumianTheme.primaryPink,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              child: Text('进入桌面'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: ChumianTheme.pinkGradientBox,
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (_currentStep > 0)
                      TextButton(
                        onPressed: _prevStep,
                        child: Text('上一步', style: TextStyle(color: ChumianTheme.primaryPink)),
                      )
                    else
                      SizedBox(width: 80),
                    Text(
                      'chumian',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: ChumianTheme.primaryPink,
                        letterSpacing: 3,
                      ),
                    ),
                    if (_currentStep < _steps.length - 1)
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _currentStep = _steps.length - 1;
                          });
                          _pageController.animateToPage(
                            _steps.length - 1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text('跳过', style: TextStyle(color: ChumianTheme.textDark.withOpacity(0.5))),
                      )
                    else
                      SizedBox(width: 80),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_steps.length, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: _currentStep == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentStep >= index
                          ? ChumianTheme.primaryPink
                          : ChumianTheme.lightPink.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _steps.length,
                  itemBuilder: (context, index) {
                    return _buildStepPage(_steps[index], index);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: _buildBottomButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepPage(Map<String, dynamic> step, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: ChumianTheme.softShadow,
            ),
            child: Icon(
              step['icon'],
              size: 60,
              color: ChumianTheme.primaryPink,
            ),
          ),
          SizedBox(height: 32),
          Text(
            step['title'],
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: ChumianTheme.textDark,
            ),
          ),
          SizedBox(height: 8),
          Text(
            step['subtitle'],
            style: TextStyle(
              fontSize: 18,
              color: ChumianTheme.primaryPink,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 24),
          Text(
            step['description'],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: ChumianTheme.textDark.withOpacity(0.7),
              height: 1.6,
            ),
          ),
          if (index == 2) ...[
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '设备名称',
                    style: TextStyle(
                      fontSize: 14,
                      color: ChumianTheme.textDark.withOpacity(0.6),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _nameController,
                    style: TextStyle(color: ChumianTheme.textDark),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Checkbox(
                        value: _agreed,
                        onChanged: (v) => setState(() => _agreed = v ?? false),
                        activeColor: ChumianTheme.primaryPink,
                      ),
                      Expanded(
                        child: Text(
                          '我已阅读并同意《用户协议》和《隐私政策》',
                          style: TextStyle(
                            fontSize: 13,
                            color: ChumianTheme.textDark.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
          if (index == 3 && _activating) ...[
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(ChumianTheme.primaryPink),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '正在激活系统...',
                    style: TextStyle(
                      color: ChumianTheme.textDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '配置系统权限和组件',
                    style: TextStyle(
                      fontSize: 12,
                      color: ChumianTheme.textDark.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    if (_currentStep < _steps.length - 1) {
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _nextStep,
          child: Text('下一步'),
        ),
      );
    } else {
      return SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: _activating ? null : _activate,
          child: _activating
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : Text('立即激活'),
        ),
      );
    }
  }
}
