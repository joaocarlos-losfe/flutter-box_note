import 'package:box_note/styles/colors.dart';
import 'package:box_note/styles/sizes.dart';
import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: Color(basicColorsDark[0]),
  ),
  scaffoldBackgroundColor: Color(
    basicColorsDark[0],
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: InputBorder.none,
  ),
  cardTheme: CardTheme(
    margin: EdgeInsets.zero,
    color: Color(basicColorsDark[1]),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(primaryRounded),
    ),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      foregroundColor: const WidgetStatePropertyAll(Colors.white),
      backgroundColor: WidgetStatePropertyAll(Color(basicColorsDark[1])),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(primaryRounded),
        ),
      ),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
    foregroundColor: const WidgetStatePropertyAll(Colors.white),
    backgroundColor: WidgetStatePropertyAll(Color(basicColorsDark[1])),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(primaryRounded)),
    ),
  )),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: Color(basicColorsDark[1]),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(secondaryRounded),
    ),
  ),
);
