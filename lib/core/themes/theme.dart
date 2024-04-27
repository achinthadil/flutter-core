import 'package:flutter/material.dart';

import '../constants/core_fonts.dart';
import 'app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final lightThemeMode = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: AppPallete.schemeColor),
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.whiteColor,
    ),
    chipTheme: const ChipThemeData(
      color: MaterialStatePropertyAll(
        AppPallete.backgroundColor,
      ),
      side: BorderSide.none,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: CoreFonts.poppins,
        fontSize: 35,
        fontWeight: FontWeight.w800,
      ),
      titleSmall: TextStyle(
        fontFamily: CoreFonts.poppins,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        fontFamily: CoreFonts.poppins,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      titleLarge: TextStyle(
        fontFamily: CoreFonts.poppins,
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
      bodySmall: TextStyle(
        fontFamily: CoreFonts.poppins,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontFamily: CoreFonts.poppins,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        fontFamily: CoreFonts.poppins,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        backgroundColor: AppPallete.schemeColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(27),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
      errorBorder: _border(AppPallete.errorColor),
    ),
  );
}
