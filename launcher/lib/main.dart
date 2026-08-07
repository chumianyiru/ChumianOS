import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/app_provider.dart';
import 'providers/widget_provider.dart';
import 'providers/settings_provider.dart';
import 'screens/launcher_screen.dart';
import 'screens/lock_screen.dart';
import 'screens/settings_screen.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
    await Future.delayed(const Duration(seconds: 2));
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  });
  runApp(const ChumianLauncherApp());
}

class ChumianLauncherApp extends StatelessWidget {
  const ChumianLauncherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => WidgetProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'ChumianOS',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(themeProvider.currentTheme),
            darkTheme: AppTheme.dark(themeProvider.currentTheme),
            themeMode: themeProvider.themeMode,
            home: const LauncherScreen(),
            routes: {
              '/lock': (context) => const LockScreen(),
              '/settings': (context) => const SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}
