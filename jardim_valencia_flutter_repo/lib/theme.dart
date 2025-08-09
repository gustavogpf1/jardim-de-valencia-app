import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JVTheme {
  static const Color black = Color(0xFF0A0A0A);
  static const Color white = Color(0xFFF5F5F5);
  static const Color glass = Color(0x33FFFFFF);
  static const Color line = Color(0x22FFFFFF);

  static ThemeData dark() {
    final textTheme = GoogleFonts.interTightTextTheme().apply(
      bodyColor: white,
      displayColor: white,
    );
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: black,
      colorScheme: const ColorScheme.dark(
        primary: white,
        onPrimary: black,
        surface: black,
      ),
      textTheme: textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardTheme(
        color: glass,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: line, width: 1),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0x11FFFFFF),
        hintStyle: textTheme.bodyMedium?.copyWith(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Colors.white),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: white,
          foregroundColor: black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: line,
        thickness: 1,
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: white,
      ),
    );
  }
}
