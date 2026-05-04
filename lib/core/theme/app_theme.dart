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
  static const Color surfaceVariantLight = Color(0xFFF1F5F9); // Light Slate
  static const Color textPrimaryLight = Color(0xFF111827); // Near-Black
  static const Color textSecondaryLight = Color(0xFF6B7280); // Mid-Gray

  // ------------------------------------
  // --- DARK MODE PALETTE (Deep Slate & Energetic Green) ---
  // ------------------------------------
  static const Color primaryDark =
      Color(0xFF10B981); // Refined Energetic Green
  static const Color secondaryDark = Color(0xFF34D399);
  static const Color backgroundDark = Color(0xFF0B1120); // Deeper Dark Navy
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color surfaceVariantDark = Color(0xFF334155);
  static const Color primaryTextDark = Color(0xFFF8FAFC);
  static const Color secondaryTextDark = Color(0xFF94A3B8);

  // Glassmorphism & Gradients
  static Color glassSurfaceDark = const Color(0xFF1E293B).withOpacity(0.7);
  static Color glassSurfaceLight = const Color(0xFFFFFFFF).withOpacity(0.7);
  static const Color glassBorderDark = Color(0xFF334155);
  static const Color glassBorderLight = Color(0xFFE2E8F0);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryDark, secondaryDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

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
      surfaceVariant: surfaceVariantLight,
      background: backgroundLight,
      onPrimary: surfaceLight,
      onBackground: textPrimaryLight,
      onSurface: textPrimaryLight,
    ),
    // Text Theme utilizes the new colors
    textTheme: GoogleFonts.interTextTheme().copyWith(
      displayLarge: GoogleFonts.poppins(
        fontSize: 56,
        fontWeight: FontWeight.w900,
        color: textPrimaryLight,
        letterSpacing: -1.5,
        height: 1.1,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 45,
        fontWeight: FontWeight.w800,
        color: textPrimaryLight,
        letterSpacing: -0.5,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: textPrimaryLight,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: textPrimaryLight,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: textPrimaryLight,
        letterSpacing: 0.1,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: textPrimaryLight,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        color: textSecondaryLight,
        height: 1.5,
      ),
      labelSmall: GoogleFonts.firaCode(
        fontSize: 12,
        color: textSecondaryLight,
        fontWeight: FontWeight.w500,
      ),
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
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      color: surfaceLight,
    ),
    dividerColor: textSecondaryLight.withOpacity(0.2),
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
      surfaceVariant: surfaceVariantDark,
      background: backgroundDark,
      onPrimary: backgroundDark,
      onBackground: primaryTextDark,
      onSurface: primaryTextDark,
    ),
    // Text Theme utilizes the new colors
    textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: GoogleFonts.poppins(
        fontSize: 56,
        fontWeight: FontWeight.w900,
        color: primaryTextDark,
        letterSpacing: -1.5,
        height: 1.1,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 45,
        fontWeight: FontWeight.w800,
        color: primaryTextDark,
        letterSpacing: -0.5,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w700,
        color: primaryTextDark,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: primaryTextDark,
      ),
      titleLarge: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: primaryTextDark,
        letterSpacing: 0.1,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        color: primaryTextDark,
        height: 1.6,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        color: secondaryTextDark,
        height: 1.5,
      ),
      labelSmall: GoogleFonts.firaCode(
        fontSize: 12,
        color: secondaryTextDark,
        fontWeight: FontWeight.w500,
      ),
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
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0xFF334155)),
      ),
      color: surfaceDark,
    ),
    dividerColor: secondaryTextDark.withOpacity(0.2),
  );
}
