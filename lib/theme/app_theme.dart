import 'package:flutter/material.dart';

class AppTheme {
  static const LinearGradient sidebarGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0B2C4D),
      Color(0xFF4A1D5F),
    ],
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [
      Color(0xFF2ED3C6),
      Color(0xFF9B3FCF),
      Color(0xFFF857A6),
    ],
  );

  static BoxShadow softShadow = BoxShadow(
    color: Colors.black12,
    blurRadius: 25,
    offset: const Offset(0, 10),
  );

  /// ✅ ADD THIS ONLY
  static ThemeData lightTheme() {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF5F7FB),
      useMaterial3: true,
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF9B3FCF),
      ),
    );
  }
}
