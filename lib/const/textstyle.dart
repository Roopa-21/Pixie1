import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/modules/scaler_module.dart';

TextStyle getTextStyle(
    {required ScalerModule scaler,
    required double fontSize,
    required FontWeight weight,
    required Color color,
    //FontWeight weight = FontWeight.w800,
    //Color color = AppColors.textColor1,
    double? letterSpacing}) {
  return TextStyle(
    fontSize: scaler.scaleFontSize(fontSize),
    fontWeight: weight,
    color: color,
    letterSpacing: letterSpacing,
    fontFamily: 'SF-Pro-Rounded',
  );
}

ThemeData appTheme(BuildContext context) {
  final ScalerModule scaler = ScalerModule(context);
  return ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.secondaryBackgroundColor,
    textTheme: TextTheme(
      displayLarge: getTextStyle(
          scaler: scaler,
          fontSize: 57,
          weight: FontWeight.w800,
          color: AppColors.textColor1),
      displayMedium: getTextStyle(
          scaler: scaler,
          fontSize: 45,
          weight: FontWeight.w600,
          color: AppColors.textColor1),
      displaySmall: getTextStyle(
          scaler: scaler,
          fontSize: 36,
          weight: FontWeight.w400,
          color: AppColors.textColor1),
      headlineLarge: getTextStyle(
          scaler: scaler,
          fontSize: 32,
          weight: FontWeight.w800,
          color: AppColors.textColor1),
      headlineMedium: getTextStyle(
          scaler: scaler,
          fontSize: 28,
          weight: FontWeight.w600,
          color: AppColors.textColor1),
      headlineSmall: getTextStyle(
          scaler: scaler,
          fontSize: 24,
          weight: FontWeight.w400,
          color: AppColors.textColor1),
      titleLarge: getTextStyle(
          scaler: scaler,
          fontSize: 22,
          weight: FontWeight.w600,
          color: AppColors.textColor1),
      titleMedium: getTextStyle(
          scaler: scaler,
          fontSize: 16,
          letterSpacing: 0.15,
          weight: FontWeight.w500,
          color: AppColors.textColor1),
      titleSmall: getTextStyle(
          scaler: scaler,
          fontSize: 14,
          color: AppColors.textColor1,
          letterSpacing: 0.1,
          weight: FontWeight.w500),
      bodyLarge: getTextStyle(
          scaler: scaler,
          fontSize: 16,
          letterSpacing: 0.15,
          weight: FontWeight.w800,
          color: AppColors.textColor1),
      bodyMedium: getTextStyle(
          scaler: scaler,
          fontSize: 14,
          letterSpacing: 0.25,
          weight: FontWeight.w800,
          color: AppColors.textColor1),
      bodySmall: getTextStyle(
          scaler: scaler,
          fontSize: 12,
          letterSpacing: 0.4,
          weight: FontWeight.w300,
          color: AppColors.textColor1),
      labelLarge: getTextStyle(
          scaler: scaler,
          fontSize: 14,
          letterSpacing: 0.1,
          color: AppColors.textColor1,
          weight: FontWeight.w500),
      labelMedium: getTextStyle(
          scaler: scaler,
          fontSize: 12,
          color: AppColors.textColor1,
          letterSpacing: 0.5,
          weight: FontWeight.w500),
      labelSmall: getTextStyle(
          scaler: scaler,
          color: AppColors.textColor1,
          fontSize: 11,
          letterSpacing: 0.5,
          weight: FontWeight.w500),
    ),

    appBarTheme: AppBarTheme(
        color: AppColors.secondaryBackgroundColor,
        titleTextStyle: TextStyle(
          color: AppColors.textColor1,
          fontSize: scaler.scaleFontSize(20.0),
        )),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primaryColor,
      foregroundColor: AppColors.textColor1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
    )),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      foregroundColor: AppColors.primaryColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
    )),
    iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: AppColors.textColor1)),
    cardColor: AppColors.secondaryColor,
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.secondaryBackgroundColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            const BorderSide(color: AppColors.secondaryColor, width: 2.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide:
            const BorderSide(color: AppColors.secondaryColor, width: 2.5),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.textColor1),
    // colorScheme: ColorScheme(brightness: brightness, primary: primary, onPrimary: onPrimary, secondary: secondary, onSecondary: onSecondary, error: error, onError: onError, surface: surface, onSurface: onSurface),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: AppColors.textColor1),
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryColor,
        onPrimary: AppColors.textColor1,
        secondary: AppColors.secondaryBackgroundColor,
        onSecondary: AppColors.secondaryBackgroundColor,
        error: Color(0xFFE57373),
        onError: Color(0xFFE53935),
        surface: AppColors.secondaryBackgroundColor,
        onSurface: AppColors.textColor1),
    // progressIndicatorTheme:
    // const ProgressIndicatorThemeData(color: AppColors.primary)
  );
}
