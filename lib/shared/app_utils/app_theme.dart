import 'package:flutter/material.dart';

enum AppTheme {
  lightAppTheme,
  darkAppTheme,
}

final Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.darkAppTheme: ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.redAccent,
    backgroundColor: Colors.deepOrange,
    textTheme: const TextTheme(
      headline3: TextStyle(color: Colors.red, fontSize: 18),
      headline4: TextStyle(color: Colors.redAccent, fontSize: 18),
    ),
  ),
  AppTheme.lightAppTheme: ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.greenAccent,
    backgroundColor: Colors.teal,
    textTheme: const TextTheme(
      headline3: TextStyle(color: Colors.green, fontSize: 18),
      headline4: TextStyle(color: Colors.greenAccent, fontSize: 18),
    ),
  ),
};
