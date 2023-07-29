import 'package:flutter/material.dart';

class AppConfigUi {
  AppConfigUi._();

  static const MaterialColor _primarySwatch = MaterialColor(0XFF0066B0, {
    50: Color(0xFFE0EDF6),
    100: Color(0xFFB3D1E7),
    200: Color(0xFF80B3D8),
    300: Color(0xFF4D94C8),
    400: Color(0xFF267DBC),
    500: Color(0XFF0066B0),
    600: Color(0xFF005EA9),
    700: Color(0xFF0053A0),
    800: Color(0xFF004997),
    900: Color(0xFF003887),
  });

  static final ThemeData theme = ThemeData(
    primarySwatch: _primarySwatch,
    primaryColor: const Color(0XFF0066B0),
    primaryColorLight: const Color(0XFF219FFF),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
      ),
      labelStyle: TextStyle(
        color: Colors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
