import 'package:flutter/material.dart';
import 'package:hellobell/presentation/core/app_color.dart';

class AppTheme extends Theme {
  const AppTheme({super.key, required super.data, required super.child});

  static final Color primaryColor = AppColors.primaryColor;
  static final Color surfaceColor = AppColors.surfaceColor;
  static final Color backgroundColor = AppColors.backgroundColor;
  static final Color darkBackgroundColor = AppColors.darkBackgroundColor;

  static ThemeData get lightTheme {
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        backgroundColor: backgroundColor,
        fontFamily: 'Inter',
        textTheme: TextTheme(
            titleLarge: TextStyle(color: AppColors.primaryColor, fontSize: 32),
            bodyMedium: TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 18)),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                primary: AppColors.white,
                backgroundColor: surfaceColor,
                padding: const EdgeInsets.symmetric(
                    vertical: 13.0, horizontal: 20.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ))));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        brightness: Brightness.dark,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: darkBackgroundColor,
        backgroundColor: darkBackgroundColor,
        fontFamily: 'Inter',
        textTheme: TextTheme(
            titleLarge: TextStyle(color: AppColors.white, fontSize: 32),
            bodyMedium: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontSize: 18)),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                primary: AppColors.white,
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(
                    vertical: 13.0, horizontal: 20.0),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ))));
  }
}
