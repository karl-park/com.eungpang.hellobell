import 'package:flutter/material.dart';

class AppColors {
  static final Color primaryColor = HexColor("#00928C");
  static final Color surfaceColor = HexColor("#DAF7F5");
  static final Color backgroundColor = HexColor("#FFFFFF");

}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
