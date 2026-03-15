import 'package:flutter/material.dart';

class MustBrandColors {
  static const green = Color(0xFF1B5E20);
  static const greenLight = Color(0xFF2E7D32);
  static const gold = Color(0xFFF9A825);
  static const goldSoft = Color(0xFFFFF4CC);
  static const surfaceTint = Color(0xFFE8F3E9);
  static const ivory = Color(0xFFFFFBF2);
}

class MustTheme {
  static ThemeData get light {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: MustBrandColors.green,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFCFE8D0),
      onPrimaryContainer: Color(0xFF0B3D10),
      secondary: MustBrandColors.gold,
      onSecondary: Color(0xFF1A1A1A),
      secondaryContainer: MustBrandColors.goldSoft,
      onSecondaryContainer: Color(0xFF4B3900),
      error: Color(0xFFB3261E),
      onError: Colors.white,
      errorContainer: Color(0xFFF9DEDC),
      onErrorContainer: Color(0xFF410E0B),
      surface: Colors.white,
      onSurface: Color(0xFF1C1B1A),
      surfaceContainerHighest: Color(0xFFF1F1EC),
      onSurfaceVariant: Color(0xFF5F6058),
      outline: Color(0xFF7A7B73),
      outlineVariant: Color(0xFFC9C9C1),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Color(0xFF31302F),
      onInverseSurface: Color(0xFFF3F0EE),
      inversePrimary: Color(0xFF9AD29D),
    );

    final base = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: MustBrandColors.ivory,
    );

    return base.copyWith(
      splashColor: MustBrandColors.gold.withOpacity(0.08),
      highlightColor: MustBrandColors.green.withOpacity(0.05),
      textTheme: base.textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: MustBrandColors.green,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: MustBrandColors.green,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.2,
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shadowColor: MustBrandColors.green.withOpacity(0.08),
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: MustBrandColors.green.withOpacity(0.08),
          ),
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: MustBrandColors.green,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MustBrandColors.green,
          side: BorderSide(color: MustBrandColors.green.withOpacity(0.4)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MustBrandColors.green,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: MustBrandColors.green.withOpacity(0.15)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: MustBrandColors.green.withOpacity(0.15)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: MustBrandColors.green, width: 1.5),
        ),
        prefixIconColor: MustBrandColors.greenLight,
        labelStyle: const TextStyle(color: MustBrandColors.greenLight),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: MustBrandColors.gold.withOpacity(0.18),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            color: selected ? MustBrandColors.green : colorScheme.onSurfaceVariant,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? MustBrandColors.green : colorScheme.onSurfaceVariant,
          );
        }),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: MustBrandColors.green,
        unselectedItemColor: Color(0xFF7A7B73),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w700),
        type: BottomNavigationBarType.fixed,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: MustBrandColors.green,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        backgroundColor: MustBrandColors.surfaceTint,
        selectedColor: MustBrandColors.goldSoft,
        side: BorderSide(color: MustBrandColors.green.withOpacity(0.1)),
        labelStyle: const TextStyle(color: MustBrandColors.green),
      ),
      dividerTheme: DividerThemeData(
        color: MustBrandColors.green.withOpacity(0.10),
        thickness: 1,
        space: 1,
      ),
    );
  }
}
