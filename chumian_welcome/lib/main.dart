import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme.dart';
import 'welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(ChumianWelcomeApp());
}

class ChumianWelcomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChumianOS 激活引导',
      debugShowCheckedModeBanner: false,
      theme: ChumianTheme.lightTheme,
      home: WelcomeScreen(),
    );
  }
}
