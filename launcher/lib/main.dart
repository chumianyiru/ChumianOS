import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'providers/app_provider.dart';
import 'providers/settings_provider.dart';
import 'providers/widget_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/launcher_screen.dart';
import 'screens/settings_screen.dart';
import 'themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [],
  );
  
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const ChumianLauncher());
}

class ChumianLauncher extends StatelessWidget {
  const ChumianLauncher({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => WidgetProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: DynamicColorBuilder(
        builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
          return Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return MaterialApp(
                title: 'ChumianOS',
                debugShowCheckedModeBanner: false,
                theme: AppThemes.lightTheme(lightDynamic),
                darkTheme: AppThemes.darkTheme(darkDynamic),
                themeMode: themeProvider.themeMode,
                home: const LauncherScreen(),
                routes: {
                  '/settings': (context) => const SettingsScreen(),
                },
              );
            },
          );
        },
      ),
    );
  }
}
