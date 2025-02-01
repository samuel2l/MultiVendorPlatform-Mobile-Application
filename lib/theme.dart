import 'package:flutter/material.dart';

const ash = Color(0xFF232327);
const lightAsh = Color(0xFF6F7384);
const black = Colors.black;
const ligthYellowLight = Color(0xFFFFF1B1);
const white = Colors.white;
const teal = Colors.teal;
final darkTheme = ThemeData(
  
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: const ColorScheme.dark().copyWith(
    primary: black,
    secondary: ash,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: teal,
      foregroundColor: white,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      minimumSize: const Size.fromHeight(55),
      backgroundColor: teal,
      foregroundColor: white,
      // minimumSize: const Size(double.infinity, 65),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  inputDecorationTheme:const InputDecorationTheme(
     border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)), // Rounded corners
      ),
    focusedBorder:  OutlineInputBorder(
      borderSide: BorderSide(color: teal, width: 2.0),
    ),
    enabledBorder:  OutlineInputBorder(
      borderSide: BorderSide(color: lightAsh, width: 1.0),
    ),
    hintStyle:  TextStyle(color: lightAsh),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: teal, // Sets the cursor color for all text fields
  ),
);

final lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  indicatorColor: black,
  colorScheme: const ColorScheme.light().copyWith(
    primary: white,
    secondary: black,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: teal,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: black,
      foregroundColor: white,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: black,
      foregroundColor: white,
      minimumSize: const Size.fromHeight(55),
      // minimumSize: const Size(double.infinity, 65),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: teal, width: 2.0),
    ),
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey, width: 1.0),
    ),
    hintStyle: const TextStyle(color: Colors.grey),
  ),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: teal, // Sets the cursor color for all text fields
  ),
);
