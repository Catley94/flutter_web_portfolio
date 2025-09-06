import 'package:flutter/material.dart';

class PortfolioTheme {
  static ThemeData lightWarm() {
    // Whitish base with warm brown/orange secondary
    const bg = Color(0xFFF8F8F6); // off-white
    const surface = Color(0xFFFFFFFF);
    const primary = Color(0xFFEDEAE3); // warm ivory as primary emphasis
    const secondary = Color(0xFFD07A28); // warm brown/orange

    final base = ThemeData.light(useMaterial3: true);
    final scheme = ColorScheme.fromSeed(
      seedColor: secondary,
      brightness: Brightness.light,
      primary: primary,
      secondary: secondary,
      background: bg,
      surface: surface,
    );

    return ThemeData.from(colorScheme: scheme, useMaterial3: true).copyWith(
      scaffoldBackgroundColor: bg,
      textTheme: _textThemeLight(ThemeData.light().textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  static TextTheme _textThemeLight(TextTheme base) {
    // Dark text for light background
    const onBg = Color(0xFF1D1B16);
    const onBgMuted = Color(0xFF4A473F);
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(color: onBg),
      displayMedium: base.displayMedium?.copyWith(color: onBg),
      titleLarge: base.titleLarge?.copyWith(color: onBg),
      bodyLarge: base.bodyLarge?.copyWith(color: onBgMuted),
      bodyMedium: base.bodyMedium?.copyWith(color: onBgMuted),
      labelLarge: base.labelLarge?.copyWith(color: onBgMuted),
    );
  }
}
