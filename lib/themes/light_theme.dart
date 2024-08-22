import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Color.fromARGB(255, 244, 243, 243), 
    primary: Color.fromARGB(255, 28, 79, 123),
    secondary: const Color(0xFF80CBC4), 
    tertiary: Color.fromARGB(255, 171, 199, 207),
    inversePrimary: Color.fromARGB(255, 37, 43, 50), 
    surfaceContainer: Colors.white
  ),
  textTheme: ThemeData.light().textTheme.apply(
    bodyColor: const Color(0xFF212121), // Dark grey for body text
    displayColor: Colors.black, // Black for display text
  ),
);