import 'package:flutter/material.dart';

class MaterialThemes {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'SF Pro Regular',
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: Colors.blue,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      showDragHandle: true,
      dragHandleColor: Colors.grey,
      dragHandleSize: Size(64, 3),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    fontFamily: 'SF Pro Regular',
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: Colors.blue,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      showDragHandle: true,
      dragHandleColor: Colors.grey,
      dragHandleSize: Size(64, 3),
    ),
  );
}