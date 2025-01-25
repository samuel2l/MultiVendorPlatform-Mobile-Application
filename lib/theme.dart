import 'package:flutter/material.dart';

const ash = Color(0xFF232327);
const lightAsh = Color(0xFFD0D0D0);
const black = Colors.black;
const ligthYellowLight = Color(0xFFFFF1B1);
const white = Colors.white;
final darkTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFF121212),
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.black,
    secondary: Colors.black,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: black, // Sets button background color
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        backgroundColor: Colors.black,
        foregroundColor: white,
        minimumSize: const Size(double.infinity, 65),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
  ),
);

final lightTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFFFFFFF),
  colorScheme: const ColorScheme.light().copyWith(
    primary: black,
    secondary: black,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: black,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: black,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
        backgroundColor: black,
        foregroundColor: white,
        minimumSize: const Size(double.infinity, 65),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
  ),
);
