import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF279DD7); // Base color
  static const Color secondary = Color(0xFF184B81); // Secondary color

  // Create a MaterialColor from the base color
  static const MaterialColor primarySwatch = MaterialColor(
    0xFF279DD7, // Base color value
    <int, Color>{
      50: Color(0xFFE1F1FB), // Lightest shade
      100: Color(0xFFB3D9F7), // Lighter shade
      200: Color(0xFF80C0F2), // Lighter shade
      300: Color(0xFF4DA6EE), // Lighter shade
      400: Color(0xFF3389E6), // Slightly darker
      500: Color(0xFF279DD7), // Base color
      600: Color(0xFF1F8BD1), // Darker shade
      700: Color(0xFF1A7BBF), // Darker shade
      800: Color(0xFF156AAB), // Darker shade
      900: Color(0xFF0D4C89), // Darkest shade
    },
  );
}
