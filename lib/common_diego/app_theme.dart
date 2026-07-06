import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    var textTheme = const TextTheme(
      titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontSize: 16),
    );
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      colorScheme: ColorScheme.light(
        primary: Colors.blue,
        secondary: Colors.orange,
      ),
      textTheme: textTheme,
    );
  }

  static ThemeData get darkTheme {
    var themeData3 = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.blueGrey,
      colorScheme: ColorScheme.dark(
        primary: Colors.blueGrey,
        secondary: Colors.teal,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(fontSize: 16),
      ),
    );
    var themeData2 = themeData3;
    var themeData = themeData2;
    return themeData;
  }
}
