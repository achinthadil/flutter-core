import 'package:flutter/material.dart';

import '../constants/core_fonts.dart';
import 'app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 1.3,
        ),
        borderRadius: BorderRadius.circular(10),
      );
  static final lightThemeMode = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: AppPallete.greenColor),
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
        fontSize: 50,
        fontWeight: FontWeight.w800,
        color: AppPallete.blackColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: CoreFonts.poppins,
        fontSize: 30,
        fontWeight: FontWeight.w800,
        color: AppPallete.blackColor,
      ),
      titleSmall: TextStyle(
        fontFamily: CoreFonts.poppins,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppPallete.blackColor,
      ),
      titleMedium: TextStyle(
        fontFamily: CoreFonts.poppins,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppPallete.blackColor,
      ),
      titleLarge: TextStyle(
        fontFamily: CoreFonts.poppins,
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppPallete.blackColor,
      ),
      bodySmall: TextStyle(
        fontFamily: CoreFonts.poppins,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppPallete.blackColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: CoreFonts.poppins,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppPallete.blackColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: CoreFonts.poppins,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppPallete.blackColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        backgroundColor: AppPallete.greenColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(18),
      border: _border(),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.focusBorderColor),
      errorBorder: _border(AppPallete.errorColor),
      hintStyle: const TextStyle(
        fontWeight: FontWeight.w400,
        fontFamily: CoreFonts.poppins,
        fontSize: 16,
      ),
      errorStyle: const TextStyle(
        color: AppPallete.errorColor,
        fontFamily: CoreFonts.poppins,
      ),
    ),
  );
}
