// lib/core/theme/app_theme.dart (MODIFIED FOR NEW AESTHETIC)

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // ------------------------------------
  // --- LIGHT MODE PALETTE (Refined Green/Teal) ---
  // ------------------------------------
  static const Color primaryLight = Color(0xFF059669); // Deep Teal/Green
  static const Color secondaryLight = Color(0xFF10B981);
  static const Color backgroundLight = Color(0xFFF8F9FA); // Off-White
  static const Color surfaceLight = Color(0xFFFFFFFF); // Pure White
  static const Color textPrimaryLight = Color(0xFF111827); // Near-Black
  static const Color textSecondaryLight = Color(0xFF6B7280); // Mid-Gray

  // ------------------------------------
  // --- DARK MODE PALETTE (Deep Slate & Energetic Green) ---
  // ------------------------------------
  static const Color primaryDark =
      Color(0xFF34D399); // Vibrant Neon Green/Teal Accent
  static const Color secondaryDark = Color(0xFF14B8A6);
  static const Color backgroundDark = Color(0xFF0F172A); // Deep Navy Slate
  static const Color surfaceDark = Color(0xFF1E293B); // Card/App Bar Surface
  static const Color primaryTextDark = Color(0xFFF1F5F9); // Soft White
  static const Color secondaryTextDark = Color(0xFF94A3B8); // Subtle Gray

  // Custom Color Constants (Used in Timeline Rail)
  static const Color secondaryTextDarkRail = secondaryTextDark;

  // ------------------------------------
  // --- THEME DATA DEFINITIONS ---
  // ------------------------------------

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryLight,
    scaffoldBackgroundColor: backgroundLight,
    colorScheme: const ColorScheme.light(
      primary: primaryLight,
      secondary: secondaryLight,
      surface: surfaceLight,
      background: backgroundLight,
      onPrimary: surfaceLight,
      onBackground: textPrimaryLight,
      onSurface: textPrimaryLight,
    ),
    // Text Theme utilizes the new colors
    textTheme: GoogleFonts.interTextTheme().copyWith(
      displayLarge: GoogleFonts.poppins(
          fontSize: 56, fontWeight: FontWeight.bold, color: textPrimaryLight),
      displayMedium: GoogleFonts.poppins(
          fontSize: 45, fontWeight: FontWeight.bold, color: textPrimaryLight),
      displaySmall: GoogleFonts.poppins(
          fontSize: 36, fontWeight: FontWeight.w600, color: textPrimaryLight),
      headlineMedium: GoogleFonts.poppins(
          fontSize: 28, fontWeight: FontWeight.w600, color: textPrimaryLight),
      titleLarge: GoogleFonts.inter(
          fontSize: 20, fontWeight: FontWeight.w600, color: textPrimaryLight),
      bodyLarge: GoogleFonts.inter(fontSize: 16, color: textPrimaryLight),
      bodyMedium: GoogleFonts.inter(fontSize: 14, color: textSecondaryLight),
      labelSmall: GoogleFonts.firaCode(fontSize: 12, color: textSecondaryLight),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryLight,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      color: surfaceLight,
    ),
    dividerColor: textSecondaryLight.withOpacity(0.5),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: primaryDark,
    scaffoldBackgroundColor: backgroundDark,
    colorScheme: const ColorScheme.dark(
      primary: primaryDark,
      secondary: secondaryDark,
      surface: surfaceDark,
      background: backgroundDark,
      onPrimary: backgroundDark,
      onBackground: primaryTextDark,
      onSurface: primaryTextDark,
    ),
    // Text Theme utilizes the new colors
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.poppins(
          fontSize: 56, fontWeight: FontWeight.bold, color: primaryTextDark),
      displayMedium: GoogleFonts.poppins(
          fontSize: 45, fontWeight: FontWeight.bold, color: primaryTextDark),
      displaySmall: GoogleFonts.poppins(
          fontSize: 36, fontWeight: FontWeight.w600, color: primaryTextDark),
      headlineMedium: GoogleFonts.poppins(
          fontSize: 28, fontWeight: FontWeight.w600, color: primaryTextDark),
      titleLarge: GoogleFonts.inter(
          fontSize: 20, fontWeight: FontWeight.w600, color: primaryTextDark),
      bodyLarge: GoogleFonts.inter(fontSize: 16, color: primaryTextDark),
      bodyMedium: GoogleFonts.inter(fontSize: 14, color: secondaryTextDark),
      labelSmall: GoogleFonts.firaCode(fontSize: 12, color: secondaryTextDark),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryDark,
        foregroundColor: backgroundDark,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF334155)),
      ),
      color: surfaceDark,
    ),
    dividerColor: secondaryTextDarkRail.withOpacity(0.5),
  );
}
