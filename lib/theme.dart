import 'package:flutter/material.dart';

const ash = Color(0xFF232327);
const lightAsh = Color(0xFF6F7384);
const black = Colors.black;
const ligthYellowLight = Color(0xFFFFF1B1);
const white = Colors.white;
const teal=Colors.teal;
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
      backgroundColor: teal,
      foregroundColor: white,
      // minimumSize: const Size(double.infinity, 65),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
);

final lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  colorScheme: const ColorScheme.light().copyWith(
    primary: white,
    secondary: black,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: teal,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        backgroundColor: black, foregroundColor: white),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: black,
      foregroundColor: white,
      minimumSize: const Size.fromHeight(65),
      // minimumSize: const Size(double.infinity, 65),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
);
