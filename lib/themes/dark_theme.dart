import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Color.fromARGB(255, 26, 49, 69), 
    primary: Color.fromARGB(255, 226, 226, 226),
    secondary: const Color(0xFF26A69A), 
    tertiary: Color.fromARGB(255, 95, 157, 190),
    inversePrimary: Color.fromARGB(255, 226, 229, 231), 
    surfaceContainer: Color.fromARGB(255, 19, 33, 45)
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    bodyColor: Colors.grey[300],
    displayColor: Colors.white,
  ),
);