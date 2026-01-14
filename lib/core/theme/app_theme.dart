import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the Pegasus productivity application.
/// Implements Contemporary Productive Minimalism with Focused Productivity Palette.
class AppTheme {
  AppTheme._();

  // Focused Productivity Palette - Light Theme Colors
  static const Color primaryLight = Color(
    0xFF2563EB,
  ); // Deep blue for trust and focus
  static const Color primaryVariantLight = Color(
    0xFF1E40AF,
  ); // Darker blue variant
  static const Color secondaryLight = Color(
    0xFF7C3AED,
  ); // Purposeful purple for workflow elements
  static const Color secondaryVariantLight = Color(
    0xFF6D28D9,
  ); // Darker purple variant
  static const Color successLight = Color(
    0xFF059669,
  ); // Clear green for completion states
  static const Color warningLight = Color(
    0xFFD97706,
  ); // Balanced orange for priority indicators
  static const Color errorLight = Color(
    0xFFDC2626,
  ); // Professional red for error states
  static const Color backgroundLight = Color(
    0xFFFFFFFF,
  ); // Pure white for maximum contrast
  static const Color surfaceLight = Color(
    0xFFF8FAFC,
  ); // Clean background that reduces eye strain
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color onBackgroundLight = Color(
    0xFF1E293B,
  ); // High contrast text color
  static const Color onSurfaceLight = Color(0xFF1E293B);
  static const Color onErrorLight = Color(0xFFFFFFFF);
  static const Color accentLight = Color(
    0xFF06B6D4,
  ); // Cyan for data highlights
  static const Color neutralLight = Color(
    0xFF64748B,
  ); // Balanced gray for secondary text

  // Focused Productivity Palette - Dark Theme Colors
  static const Color primaryDark = Color(
    0xFF3B82F6,
  ); // Brighter blue for dark mode
  static const Color primaryVariantDark = Color(0xFF2563EB);
  static const Color secondaryDark = Color(
    0xFF8B5CF6,
  ); // Brighter purple for dark mode
  static const Color secondaryVariantDark = Color(0xFF7C3AED);
  static const Color successDark = Color(
    0xFF10B981,
  ); // Brighter green for dark mode
  static const Color warningDark = Color(
    0xFFF59E0B,
  ); // Brighter orange for dark mode
  static const Color errorDark = Color(
    0xFFEF4444,
  ); // Brighter red for dark mode
  static const Color backgroundDark = Color(0xFF0F172A); // Deep dark background
  static const Color surfaceDark = Color(0xFF1E293B); // Elevated surface color
  static const Color onPrimaryDark = Color(0xFFFFFFFF);
  static const Color onSecondaryDark = Color(0xFFFFFFFF);
  static const Color onBackgroundDark = Color(
    0xFFF1F5F9,
  ); // High contrast text for dark
  static const Color onSurfaceDark = Color(0xFFF1F5F9);
  static const Color onErrorDark = Color(0xFFFFFFFF);
  static const Color accentDark = Color(
    0xFF22D3EE,
  ); // Brighter cyan for dark mode
  static const Color neutralDark = Color(
    0xFF94A3B8,
  ); // Lighter gray for dark mode

  // Card and dialog colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF1E293B);
  static const Color dialogLight = Color(0xFFFFFFFF);
  static const Color dialogDark = Color(0xFF1E293B);

  // Shadow colors - Subtle Elevation System (elevation 1-4)
  static const Color shadowLight = Color(
    0x0A000000,
  ); // Minimal shadow for light theme
  static const Color shadowDark = Color(
    0x14000000,
  ); // Slightly stronger for dark theme

  // Divider colors - Purposeful Space Definition
  static const Color dividerLight = Color(0xFFE2E8F0);
  static const Color dividerDark = Color(0xFF334155);

  // Text colors with proper emphasis levels
  static const Color textHighEmphasisLight = Color(0xFF1E293B); // 100% opacity
  static const Color textMediumEmphasisLight = Color(
    0xFF64748B,
  ); // 60% emphasis
  static const Color textDisabledLight = Color(0xFF94A3B8); // 38% emphasis

  static const Color textHighEmphasisDark = Color(0xFFF1F5F9); // 100% opacity
  static const Color textMediumEmphasisDark = Color(0xFF94A3B8); // 60% emphasis
  static const Color textDisabledDark = Color(0xFF64748B); // 38% emphasis

  /// Light theme - Contemporary Productive Minimalism
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: onPrimaryLight,
      primaryContainer: primaryVariantLight,
      onPrimaryContainer: onPrimaryLight,
      secondary: secondaryLight,
      onSecondary: onSecondaryLight,
      secondaryContainer: secondaryVariantLight,
      onSecondaryContainer: onSecondaryLight,
      tertiary: accentLight,
      onTertiary: onPrimaryLight,
      tertiaryContainer: accentLight,
      onTertiaryContainer: onPrimaryLight,
      error: errorLight,
      onError: onErrorLight,
      surface: surfaceLight,
      onSurface: onSurfaceLight,
      onSurfaceVariant: textMediumEmphasisLight,
      outline: dividerLight,
      outlineVariant: dividerLight,
      shadow: shadowLight,
      scrim: shadowLight,
      inverseSurface: surfaceDark,
      onInverseSurface: onSurfaceDark,
      inversePrimary: primaryDark,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    dividerColor: dividerLight,
    appBarTheme: AppBarThemeData(
      backgroundColor: surfaceLight,
      foregroundColor: onSurfaceLight,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: onSurfaceLight,
        letterSpacing: 0.15,
      ),
      iconTheme: IconThemeData(color: onSurfaceLight),
    ),
    cardTheme: CardThemeData(
      color: cardLight,
      elevation: 1.0, // Minimal elevation per Subtle Elevation System
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceLight,
      selectedItemColor: primaryLight,
      unselectedItemColor: textMediumEmphasisLight,
      elevation: 2.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryLight,
      foregroundColor: onPrimaryLight,
      elevation: 2.0,
      focusElevation: 4.0,
      hoverElevation: 4.0,
      highlightElevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimaryLight,
        backgroundColor: primaryLight,
        elevation: 1.0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        minimumSize: const Size(88, 48), // Touch-friendly 48dp minimum
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        minimumSize: const Size(88, 48),
        side: const BorderSide(color: primaryLight, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: const Size(88, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: true),
    inputDecorationTheme: InputDecorationThemeData(
      fillColor: backgroundLight,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: dividerLight, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: dividerLight, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: primaryLight, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorLight, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorLight, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: textMediumEmphasisLight,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textDisabledLight,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorLight,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return neutralLight;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight.withValues(alpha: 0.5);
        }
        return neutralLight.withValues(alpha: 0.3);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(onPrimaryLight),
      side: const BorderSide(color: dividerLight, width: 2.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return neutralLight;
      }),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryLight,
      linearTrackColor: dividerLight,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryLight,
      thumbColor: primaryLight,
      overlayColor: primaryLight.withValues(alpha: 0.2),
      inactiveTrackColor: dividerLight,
      valueIndicatorColor: primaryLight,
      valueIndicatorTextStyle: GoogleFonts.inter(
        color: onPrimaryLight,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: primaryLight,
      unselectedLabelColor: textMediumEmphasisLight,
      indicatorColor: primaryLight,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: onSurfaceLight.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: surfaceLight,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: onSurfaceLight,
      contentTextStyle: GoogleFonts.inter(
        color: surfaceLight,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: accentLight,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 2.0,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceLight,
      selectedColor: primaryLight.withValues(alpha: 0.2),
      disabledColor: dividerLight,
      labelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
      secondaryLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: dividerLight, width: 1.0),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: dividerLight,
      thickness: 1.0,
      space: 1.0,
    ), dialogTheme: DialogThemeData(backgroundColor: dialogLight),
  );

  /// Dark theme - Contemporary Productive Minimalism
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryDark,
      onPrimary: onPrimaryDark,
      primaryContainer: primaryVariantDark,
      onPrimaryContainer: onPrimaryDark,
      secondary: secondaryDark,
      onSecondary: onSecondaryDark,
      secondaryContainer: secondaryVariantDark,
      onSecondaryContainer: onSecondaryDark,
      tertiary: accentDark,
      onTertiary: onPrimaryDark,
      tertiaryContainer: accentDark,
      onTertiaryContainer: onPrimaryDark,
      error: errorDark,
      onError: onErrorDark,
      surface: surfaceDark,
      onSurface: onSurfaceDark,
      onSurfaceVariant: textMediumEmphasisDark,
      outline: dividerDark,
      outlineVariant: dividerDark,
      shadow: shadowDark,
      scrim: shadowDark,
      inverseSurface: surfaceLight,
      onInverseSurface: onSurfaceLight,
      inversePrimary: primaryLight,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    dividerColor: dividerDark,
    appBarTheme: AppBarThemeData(
      backgroundColor: surfaceDark,
      foregroundColor: onSurfaceDark,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: onSurfaceDark,
        letterSpacing: 0.15,
      ),
      iconTheme: IconThemeData(color: onSurfaceDark),
    ),
    cardTheme: CardThemeData(
      color: cardDark,
      elevation: 1.0,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: primaryDark,
      unselectedItemColor: textMediumEmphasisDark,
      elevation: 2.0,
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryDark,
      foregroundColor: onPrimaryDark,
      elevation: 2.0,
      focusElevation: 4.0,
      hoverElevation: 4.0,
      highlightElevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimaryDark,
        backgroundColor: primaryDark,
        elevation: 1.0,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        minimumSize: const Size(88, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        minimumSize: const Size(88, 48),
        side: const BorderSide(color: primaryDark, width: 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: const Size(88, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: false),
    inputDecorationTheme: InputDecorationThemeData(
      fillColor: backgroundDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: dividerDark, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: dividerDark, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: primaryDark, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorDark, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorDark, width: 2.0),
      ),
      labelStyle: GoogleFonts.inter(
        color: textMediumEmphasisDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.inter(
        color: textDisabledDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      errorStyle: GoogleFonts.inter(
        color: errorDark,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return neutralDark;
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark.withValues(alpha: 0.5);
        }
        return neutralDark.withValues(alpha: 0.3);
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(onPrimaryDark),
      side: const BorderSide(color: dividerDark, width: 2.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return neutralDark;
      }),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryDark,
      linearTrackColor: dividerDark,
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryDark,
      thumbColor: primaryDark,
      overlayColor: primaryDark.withValues(alpha: 0.2),
      inactiveTrackColor: dividerDark,
      valueIndicatorColor: primaryDark,
      valueIndicatorTextStyle: GoogleFonts.inter(
        color: onPrimaryDark,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
    tabBarTheme: TabBarThemeData(
      labelColor: primaryDark,
      unselectedLabelColor: textMediumEmphasisDark,
      indicatorColor: primaryDark,
      indicatorSize: TabBarIndicatorSize.label,
      labelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
      ),
      unselectedLabelStyle: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.1,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: onSurfaceDark.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.inter(
        color: surfaceDark,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: onSurfaceDark,
      contentTextStyle: GoogleFonts.inter(
        color: surfaceDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: accentDark,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 2.0,
    ),
    chipTheme: ChipThemeData(
      backgroundColor: surfaceDark,
      selectedColor: primaryDark.withValues(alpha: 0.2),
      disabledColor: dividerDark,
      labelStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
      secondaryLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: dividerDark, width: 1.0),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: dividerDark,
      thickness: 1.0,
      space: 1.0,
    ), dialogTheme: DialogThemeData(backgroundColor: dialogDark),
  );

  /// Helper method to build text theme based on brightness
  /// Uses Inter font family for all text styles per Typography Standards
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textHighEmphasis = isLight
        ? textHighEmphasisLight
        : textHighEmphasisDark;
    final Color textMediumEmphasis = isLight
        ? textMediumEmphasisLight
        : textMediumEmphasisDark;
    final Color textDisabled = isLight ? textDisabledLight : textDisabledDark;

    return TextTheme(
      // Display styles - Inter w700 for headings
      displayLarge: GoogleFonts.inter(
        fontSize: 57,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: GoogleFonts.inter(
        fontSize: 45,
        fontWeight: FontWeight.w700,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.22,
      ),
      // Headline styles - Inter w600 for headings
      headlineLarge: GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: GoogleFonts.inter(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.33,
      ),
      // Title styles - Inter w500/w600 for headings
      titleLarge: GoogleFonts.inter(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: textHighEmphasis,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.15,
        height: 1.50,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      // Body styles - Inter w400 for body text
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.5,
        height: 1.50,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textHighEmphasis,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textMediumEmphasis,
        letterSpacing: 0.4,
        height: 1.33,
      ),
      // Label styles - Inter w500 for captions
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textHighEmphasis,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textMediumEmphasis,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: textDisabled,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    );
  }

  /// Get success color based on brightness
  static Color getSuccessColor(Brightness brightness) {
    return brightness == Brightness.light ? successLight : successDark;
  }

  /// Get warning color based on brightness
  static Color getWarningColor(Brightness brightness) {
    return brightness == Brightness.light ? warningLight : warningDark;
  }

  /// Get accent color based on brightness
  static Color getAccentColor(Brightness brightness) {
    return brightness == Brightness.light ? accentLight : accentDark;
  }

  /// Get neutral color based on brightness
  static Color getNeutralColor(Brightness brightness) {
    return brightness == Brightness.light ? neutralLight : neutralDark;
  }
}
