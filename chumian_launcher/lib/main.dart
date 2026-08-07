import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'home/home_screen.dart';
import 'settings/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(ChumianLauncherApp());
}

class ChumianLauncherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChumianOS',
      debugShowCheckedModeBanner: false,
      theme: ChumianTheme.lightTheme,
      home: ChumianHomeScreen(),
      routes: {
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
