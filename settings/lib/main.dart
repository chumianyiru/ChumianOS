import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/settings_provider.dart';
import 'screens/home_screen.dart';
import 'screens/display_screen.dart';
import 'screens/sound_screen.dart';
import 'screens/battery_screen.dart';
import 'screens/storage_screen.dart';
import 'screens/about_screen.dart';
import 'screens/apps_screen.dart';
import 'screens/security_screen.dart';
import 'screens/network_screen.dart';
import 'screens/file_manager_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const ChumianSettingsApp());
}

class ChumianSettingsApp extends StatelessWidget {
  const ChumianSettingsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: MaterialApp(
        title: 'ChumianOS 设置',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF6B9D),
            brightness: Brightness.light,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF6B9D),
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeMode.system,
        home: const HomeScreen(),
        routes: {
          '/display': (context) => const DisplayScreen(),
          '/sound': (context) => const SoundScreen(),
          '/battery': (context) => const BatteryScreen(),
          '/storage': (context) => const StorageScreen(),
          '/about': (context) => const AboutScreen(),
          '/apps': (context) => const AppsScreen(),
          '/security': (context) => const SecurityScreen(),
          '/network': (context) => const NetworkScreen(),
          '/files': (context) => const FileManagerScreen(),
        },
      ),
    );
  }
}
