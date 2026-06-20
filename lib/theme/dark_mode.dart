import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  fontFamily: "Montserrat",
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    // Main background
    surface: Color(0xFF090909),

    // Orange accent
    primary: Color(0xFFFF8C00),

    // Post containers, cards
    secondary: Color(0xFF141414),

    // Text fields, elevated surfaces
    tertiary: Color(0xFF1F1F1F),

    // Text color
    inversePrimary: Color(0xFFF5F5F5),
  ),

  scaffoldBackgroundColor: const Color(0xFF090909),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF090909),
    elevation: 0,
  ),

  drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFF090909)),

  cardTheme: CardThemeData(
    color: const Color(0xFF141414),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFFFF8C00),
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1F1F1F),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFFF8C00), width: 2),
    ),
  ),
);
