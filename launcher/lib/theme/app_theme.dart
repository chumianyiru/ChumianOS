import 'package:flutter/material.dart';

class AppTheme {
  static const Color _pinkSeed = Color(0xFFFF6B9D);
  static const Color _purpleSeed = Color(0xFF9C6BFF);
  static const Color _blueSeed = Color(0xFF6B9DFF);
  static const Color _greenSeed = Color(0xFF6BFF9D);
  static const Color _yellowSeed = Color(0xFFFFD96B);
  static const Color _orangeSeed = Color(0xFFFF9D6B);
  static const Color _redSeed = Color(0xFFFF6B6B);
  static const Color _tealSeed = Color(0xFF6BFFD9);
  static const Color _monoSeed = Color(0xFF888888);
  static const Color _roseSeed = Color(0xFFFF6B8E);

  static final Map<String, Color> _themeSeeds = {
    'sakura': _pinkSeed,
    'lavender': _purpleSeed,
    'sky': _blueSeed,
    'mint': _greenSeed,
    'sunshine': _yellowSeed,
    'peach': _orangeSeed,
    'cherry': _redSeed,
    'ocean': _tealSeed,
    'monochrome': _monoSeed,
    'rose': _roseSeed,
  };

  static ThemeData light(String themeName) {
    final seed = _themeSeeds[themeName] ?? _pinkSeed;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.light,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        color: colorScheme.surfaceContainerHighest.withOpacity(0.5),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: const CircleBorder(),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
      ),
    );
  }

  static ThemeData dark(String themeName) {
    final seed = _themeSeeds[themeName] ?? _pinkSeed;
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: Brightness.dark,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        color: colorScheme.surfaceContainerHigh.withOpacity(0.5),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: const CircleBorder(),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: colorScheme.surfaceContainerHigh,
      ),
    );
  }

  static List<Map<String, dynamic>> get themeList => [
    {'name': 'sakura', 'displayName': '樱花粉', 'color': _pinkSeed},
    {'name': 'lavender', 'displayName': '薰衣草', 'color': _purpleSeed},
    {'name': 'sky', 'displayName': '天空蓝', 'color': _blueSeed},
    {'name': 'mint', 'displayName': '薄荷绿', 'color': _greenSeed},
    {'name': 'sunshine', 'displayName': '阳光黄', 'color': _yellowSeed},
    {'name': 'peach', 'displayName': '蜜桃橙', 'color': _orangeSeed},
    {'name': 'cherry', 'displayName': '樱桃红', 'color': _redSeed},
    {'name': 'ocean', 'displayName': '海洋青', 'color': _tealSeed},
    {'name': 'monochrome', 'displayName': '极简灰', 'color': _monoSeed},
    {'name': 'rose', 'displayName': '玫瑰红', 'color': _roseSeed},
  ];
}
