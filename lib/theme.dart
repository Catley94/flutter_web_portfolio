import 'package:flutter/material.dart';

class PortfolioTheme {
  static ThemeData darkNeon() {
    const bg = Color(0xFF0B0E14);
    const primary = Color(0xFF00FFC6); // neon mint
    const accent = Color(0xFF9B5CFF); // purple
    const surface = Color(0xFF121725);

    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: bg,
      colorScheme: base.colorScheme.copyWith(
        primary: primary,
        secondary: accent,
        surface: surface,
        background: bg,
      ),
      textTheme: _textTheme(base.textTheme),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  static TextTheme _textTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(color: Colors.white),
      displayMedium: base.displayMedium?.copyWith(color: Colors.white),
      titleLarge: base.titleLarge?.copyWith(color: Colors.white),
      bodyLarge: base.bodyLarge?.copyWith(color: Colors.white70),
      bodyMedium: base.bodyMedium?.copyWith(color: Colors.white70),
      labelLarge: base.labelLarge?.copyWith(color: Colors.white70),
    );
  }
}
