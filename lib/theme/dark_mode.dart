import 'package:flutter/material.dart';

/// ===============================
/// BRAND
/// ===============================

const primary = Color(0xFFFF8C00);
// Highlight
const primaryLight = Color(0xFFFFB347);
// Hover / lighter accent
const primarySoft = Color(0xFFFFC971);
// Main glow
const primaryGlow = Color(0xFFFFA726);
// Darker accent
const primaryDark = Color(0xFFD46A00);
// Very dark orange
const primaryDeep = Color(0xFF9C4700);

/// ===============================
/// SURFACES
/// ===============================

/// App background
const background = Color(0xFF090909);

/// Cards / Posts
const secondary = Color(0xFF141414);

/// Inputs / Elevated Containers
const tertiary = Color(0xFF1F1F1F);

/// ===============================
/// TEXT
/// ===============================

/// Main text
const inversePrimary = Color(0xFFF5F5F5);

/// Secondary text
const textSecondary = Color(0xFFB0B0B0);

/// Hints / Disabled
const textHint = Color(0xFF7A7A7A);

/// ===============================
/// BORDERS
/// ===============================

const border = Color(0x22FFFFFF);

const divider = Color(0x14FFFFFF);

const primaryBorder = Color(0x66FFB347); // 40% opacity

/// ===============================
/// GLASS
/// ===============================

const glass = Color(0x0DFFFFFF);

const glassBorder = Color(0x22FFFFFF);

const primaryGlass = Color(0x22FFB347); // 13% opacity

/// ===============================
/// STATUS
/// ===============================

const success = Color(0xFF4CAF50);

const warning = Color(0xFFFFB300);

const error = Color(0xFFE53935);

ThemeData darkMode = ThemeData(
  fontFamily: "Montserrat",
  useMaterial3: true,
  colorScheme: const ColorScheme.dark(
    // Main background
    surface: background,

    // Orange accent
    primary: primary,

    // Post containers, cards
    secondary: secondary,

    // Text fields, elevated surfaces
    tertiary: tertiary,

    // Text color
    inversePrimary: inversePrimary,

    error: error,

    onPrimary: inversePrimary,

    onSurface: inversePrimary,
  ),

  scaffoldBackgroundColor: background,

  appBarTheme: const AppBarTheme(backgroundColor: background, elevation: 0),

  drawerTheme: const DrawerThemeData(backgroundColor: background),

  cardTheme: CardThemeData(
    color: secondary,

    elevation: 0,

    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primary,

      foregroundColor: Colors.white,

      elevation: 0,

      padding: const EdgeInsets.symmetric(vertical: 18),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,

    fillColor: tertiary,

    hintStyle: const TextStyle(color: textHint, fontSize: 14),

    contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
    suffixIconColor: textHint,
    prefixIconColor: textHint,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),

    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(color: primaryLight, width: 1.5),
    ),
  ),

  textTheme: const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.bold,
      color: inversePrimary,
    ),

    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w700,
      color: inversePrimary,
    ),

    bodyLarge: TextStyle(fontSize: 16, color: inversePrimary),

    bodyMedium: TextStyle(fontSize: 14, color: textSecondary),
  ),
);

class AppSpacing {
  static const xs = 4.0;

  static const sm = 8.0;

  static const md = 16.0;

  static const lg = 24.0;

  static const xl = 32.0;

  static const xxl = 48.0;
}
