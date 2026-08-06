import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActivationScreen extends StatefulWidget {
  const ActivationScreen({super.key});

  @override
  State<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends State<ActivationScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  static const platform = MethodChannel('com.chumianos.setupwizard/system');
  bool _activating = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  children: [
                    _buildWelcomePage(),
                    _buildLanguagePage(),
                    _buildWifiPage(),
                    _buildTermsPage(),
                    _buildActivationPage(),
                  ],
                ),
              ),
              _buildBottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomePage() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Icon(Icons.android, size: 60, color: Theme.of(context).colorScheme.onPrimary),
          ),
          const SizedBox(height: 32),
          Text('欢迎使用 ChumianOS', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Text('全新体验，从激活开始', style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget _buildLanguagePage() {
    final languages = ['简体中文', 'English', '繁體中文', '日本語', '한국어'];
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('选择语言', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 24),
          ...languages.map((l) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              title: Text(l),
              trailing: l == '简体中文' ? const Icon(Icons.check_circle, color: Colors.green) : null,
              onTap: () => _nextPage(),
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildWifiPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('网络连接', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 24),
          Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              leading: const Icon(Icons.wifi),
              title: const Text('ChumianOS-5G'),
              subtitle: const Text('信号强'),
              trailing: FilledButton(onPressed: () => _nextPage(), child: const Text('连接')),
            ),
          ),
          const Spacer(),
          Center(
            child: TextButton(onPressed: () => _nextPage(), child: const Text('跳过此步骤')),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsPage() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('用户协议', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: const SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Text('欢迎使用 ChumianOS\n\n1. 系统权限说明\n2. 隐私政策\n3. 开源许可\n\n点击同意即表示您接受以上条款。'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => _nextPage(),
            style: FilledButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
            child: const Text('同意并继续'),
          ),
        ],
      ),
    );
  }

  Widget _buildActivationPage() {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.verified_user, size: 80, color: Colors.green),
          const SizedBox(height: 24),
          Text('激活引导', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 16),
          const Text('点击下方按钮完成激活，系统将自动进入桌面并卸载此引导应用。', textAlign: TextAlign.center),
          const SizedBox(height: 32),
          if (_activating)
            const CircularProgressIndicator()
          else
            FilledButton.icon(
              onPressed: _activateDevice,
              icon: const Icon(Icons.rocket_launch),
              label: const Text('立即激活'),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage > 0)
            TextButton(
              onPressed: () => _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              child: const Text('上一步'),
            )
          else
            const SizedBox(width: 80),
          Row(
            children: List.generate(5, (i) => Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == _currentPage
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline.withOpacity(0.3),
              ),
            )),
          ),
          if (_currentPage < 4)
            TextButton(
              onPressed: () => _nextPage(),
              child: const Text('下一步'),
            )
          else
            const SizedBox(width: 80),
        ],
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < 4) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _activateDevice() async {
    setState(() => _activating = true);
    try {
      await platform.invokeMethod('markActivated');
      await platform.invokeMethod('launchLauncher');
      await Future.delayed(const Duration(seconds: 2));
      await platform.invokeMethod('selfUninstall');
    } catch (e) {
      setState(() => _activating = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('激活失败: $e')),
      );
    }
  }
}
