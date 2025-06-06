import 'package:flutter/material.dart';

// Color orange = const Color.fromRGBO(241, 59, 9, 1);
Color orange = Color.fromRGBO(233, 106, 50, 1);
Color PRIM = Color.fromRGBO(39, 39, 39, 1);

ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: PRIM, primary: PRIM),
  primaryColor: PRIM,

  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.deepPurple,
    selectionColor: Colors.deepPurple.shade100,
    selectionHandleColor: Colors.deepPurple,
  ),

  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black12, width: 1),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black12, width: 1), //
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1), //
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1), //
    ),

    // Base label style (when not floating)
    labelStyle: TextStyle(color: Colors.black, fontSize: 16),

    // Optional: style for the floating (shrunk) label
    floatingLabelStyle: TextStyle(color: Colors.black, fontSize: 14),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      // padding: const EdgeInsets.symmetric(horizontal: 24),
      backgroundColor: orange, // Explicitly set background here
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 16),
      elevation: 0,
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      // maximumSize: Size(0, 10),
      side: BorderSide(color: Colors.black38),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Colors.black87, width: 2),
    checkColor: WidgetStatePropertyAll(orange),
  ),
);
