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

  // elevatedButtonTheme: ElevatedButtonThemeData(
  //   style: ElevatedButton.styleFrom(
  //     minimumSize: const Size.fromHeight(50),
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //     // padding: const EdgeInsets.symmetric(horizontal: 24),
  //     backgroundColor: orange, // Explicitly set background here
  //     foregroundColor: Colors.white,
  //     textStyle: const TextStyle(fontSize: 16),
  //     elevation: 0,
  //     splashFactory:
  //         NoSplash.splashFactory, // Disable long press/press splash effect
  //     overlayColor: Colors.transparent,
  //     animationDuration: Duration.zero,
  //   ),
  // ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      minimumSize: WidgetStatePropertyAll<Size>(const Size.fromHeight(50)),
      maximumSize: WidgetStatePropertyAll<Size>(
        const Size(double.infinity, double.infinity),
      ),
      shape: WidgetStatePropertyAll<OutlinedBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      alignment: Alignment.center,
      // Set solid background color to #F13B09
      backgroundColor: WidgetStatePropertyAll(Color(0xFFF13B09)),
      foregroundColor: WidgetStatePropertyAll(Colors.white),
      elevation: WidgetStatePropertyAll(0),
      splashFactory: NoSplash.splashFactory,
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      shadowColor: WidgetStatePropertyAll(Colors.transparent),
      surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
      animationDuration: Duration.zero,
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w500, // Medium
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      minimumSize: WidgetStatePropertyAll(Size(double.infinity, 50)),
      maximumSize: WidgetStatePropertyAll(
        Size(double.infinity, double.infinity),
      ),
      backgroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.white;
        }
        return const Color(0xFFFFF5F5); // light pink background when unselected
      }),
      foregroundColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.selected)) {
          return orange;
        }
        return Colors.black54;
      }),
      side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
        if (states.contains(WidgetState.selected)) {
          return BorderSide(color: orange, width: 1.5);
        }
        return const BorderSide(color: Colors.black26, width: 1);
      }),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      textStyle: WidgetStatePropertyAll(
        const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16)),
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
      splashFactory: NoSplash.splashFactory,
      elevation: WidgetStatePropertyAll(0),
      surfaceTintColor: WidgetStatePropertyAll(Colors.transparent),
      shadowColor: WidgetStatePropertyAll(Colors.transparent),
    ),
  ),

  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Colors.black87, width: 2), // visible border
    checkColor: WidgetStatePropertyAll(Colors.white), // tick color (foreground)
    fillColor: WidgetStatePropertyAll(Colors.white), // background of box
    overlayColor: WidgetStatePropertyAll(
      Color(0x1AF13B09),
    ), // subtle orange overlay on press (optional)
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    // The activeColor is the border color when checked, but we want border to stay black, so leave as default
    // We'll set the tick color in the Checkbox widget directly for orange
  ),
);
