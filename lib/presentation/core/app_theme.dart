import 'package:flutter/material.dart';
import 'package:hellobell/presentation/core/app_color.dart';

class AppTheme extends Theme {
  const AppTheme({
    super.key,
    required super.data,
    required super.child
  });

  static final Color primaryColor = AppColors.primaryColor;
  static final Color surfaceColor = AppColors.surfaceColor;
  static final Color backgroundColor = AppColors.backgroundColor;


  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        fontFamily: 'Montserrat',
        buttonTheme: ButtonThemeData(
          shape: const RoundedRectangleBorder(),
          padding: const EdgeInsets.all(16),
          buttonColor: surfaceColor
        )
    );
  }
}
