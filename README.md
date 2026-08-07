# ChumianOS

ChumianOS 是一个基于 Flutter 开发的自定义安卓系统体验，包含三个独立应用：桌面启动器、系统设置和开机引导。

## 应用列表

### 1. ChumianOS 桌面启动器 (Launcher)
- 替换系统默认桌面
- 全屏手势导航
- 所有桌面图标强制圆形裁剪
- 长按桌面进入编辑模式
- 屏蔽应用抽屉，所有APP全部平铺
- 内置30+桌面小组件
- 10套桌面图标主题
- 自制粉色通知栏
- 启动器接管锁屏

### 2. ChumianOS 系统设置 (Settings)
- 拥有系统权限
- 全部圆形UI风格
- 关于手机页面显示 ChumianOS
- 连续点击版本号开启开发者模式
- 可触发安卓彩蛋
- 内置文件管理器

### 3. ChumianOS 开机引导 (Setup Wizard)
- 系统启动后第一个弹出
- 多步骤配置引导
- 点击激活后自动卸载自身
- 跳转到桌面启动器

## 技术栈
- Flutter / Dart
- Material 3 (Material You)
- Android (arm64 APK)
- GitHub Actions 云端构建

## 构建状态
[![Build ChumianOS APKs](https://github.com/chumianyiru/ChumianOS/actions/workflows/build.yml/badge.svg)](https://github.com/chumianyiru/ChumianOS/actions/workflows/build.yml)

## 下载
从 [GitHub Actions](https://github.com/chumianyiru/ChumianOS/actions) 下载最新构建的 APK 文件。

## 安装说明
1. 下载三个 APK 文件
2. 先安装 Setup Wizard 和 Settings
3. 最后安装 Launcher
4. 按 Home 键，选择 ChumianOS 启动器
5. 按照开机引导完成激活

## 注意事项
- 部分系统级功能需要 root 权限或手动授权
- 建议在 Android 10+ 设备上使用
- 首次使用需要授予相应权限
