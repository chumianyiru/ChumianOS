import 'package:flutter/material.dart';

class ChumianTheme {
  static const Color primaryPink = Color(0xFFFF80AB);
  static const Color lightPink = Color(0xFFFFB2D5);
  static const Color darkPink = Color(0xFFF06292);
  static const Color accentPink = Color(0xFFFF4081);
  static const Color bgGradientStart = Color(0xFFFFCDD2);
  static const Color bgGradientEnd = Color(0xFFF8BBD0);
  static const Color cardPink = Color(0xFFFFF0F5);
  static const Color textDark = Color(0xFF4A2030);
  static const Color textLight = Color(0xFFFFFFFF);

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryPink,
      brightness: Brightness.light,
      primary: primaryPink,
      secondary: lightPink,
      surface: cardPink,
      error: Color(0xFFE53935),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.transparent,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: textDark,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(color: textDark),
      ),
      cardTheme: CardThemeData(
        color: cardPink,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryPink,
        foregroundColor: textLight,
        shape: CircleBorder(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryPink,
          foregroundColor: textLight,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryPink,
        ),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(primaryPink),
        trackColor: WidgetStateProperty.all(lightPink),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryPink,
        thumbColor: primaryPink,
        overlayColor: primaryPink.withOpacity(0.2),
      ),
      iconTheme: IconThemeData(color: textDark),
      textTheme: TextTheme(
        headlineLarge: TextStyle(color: textDark, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(color: textDark, fontWeight: FontWeight.w600),
        titleLarge: TextStyle(color: textDark, fontWeight: FontWeight.w600),
        titleMedium: TextStyle(color: textDark, fontWeight: FontWeight.w500),
        bodyLarge: TextStyle(color: textDark),
        bodyMedium: TextStyle(color: textDark),
        labelLarge: TextStyle(color: textDark, fontWeight: FontWeight.w600),
      ),
      dividerTheme: DividerThemeData(
        color: lightPink.withOpacity(0.3),
        thickness: 1,
      ),
      listTileTheme: ListTileThemeData(
        iconColor: primaryPink,
        textColor: textDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: primaryPink.withOpacity(0.15),
      blurRadius: 12,
      offset: Offset(0, 4),
    ),
  ];

  static BoxDecoration get pinkGradientBox => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [bgGradientStart, bgGradientEnd],
    ),
  );

  static BoxDecoration circlePinkDecoration({Color? color}) => BoxDecoration(
    color: color ?? primaryPink,
    shape: BoxShape.circle,
    boxShadow: softShadow,
  );
}
