import 'package:flutter/material.dart';

import 'colors.dart';

MaterialColor convertColor(int colorValue) {
  final colorString = colorValue.toRadixString(16).padLeft(8, '0');
  final alpha = int.parse(colorString.substring(0, 2), radix: 16);
  final red = int.parse(colorString.substring(2, 4), radix: 16);
  final green = int.parse(colorString.substring(4, 6), radix: 16);
  final blue = int.parse(colorString.substring(6, 8), radix: 16);

  return MaterialColor(colorValue, <int, Color>{
    50: Color.fromRGBO(red, green, blue, 0.1),
    100: Color.fromRGBO(red, green, blue, 0.2),
    200: Color.fromRGBO(red, green, blue, 0.3),
    300: Color.fromRGBO(red, green, blue, 0.4),
    400: Color.fromRGBO(red, green, blue, 0.5),
    500: Color.fromRGBO(red, green, blue, 0.6),
    600: Color.fromRGBO(red, green, blue, 0.7),
    700: Color.fromRGBO(red, green, blue, 0.8),
    800: Color.fromRGBO(red, green, blue, 0.9),
    900: Color.fromRGBO(red, green, blue, 1.0),
  });
}

class AppTheme {
  static TextTheme lightTextTheme = const TextTheme(
    displayLarge: TextStyle(
      fontFamily: "Caros",
      fontSize: 16.0,
      fontWeight: FontWeight.w800,
      color: AppColors.secondaryColor,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontFamily: "Caros",
      fontSize: 16.0,
      color: AppColors.secondaryColor,
    ),
    titleMedium: TextStyle(
      fontFamily: "Caros",
      fontSize: 13.0,
      color: AppColors.secondaryColor,
    ),
  );
  // 2

  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: AppColors.primaryColor,
          onPrimary: Colors.white,
          onPrimaryContainer: Colors.amber,
          secondary: AppColors.primaryColor.withOpacity(0.3),
          onSecondary: Colors.black,
          error: Colors.red,
          onError: Colors.pink,
          background: AppColors.primaryColor.withOpacity(0.3),
          onBackground: Colors.black,
          surface: AppColors.primaryColor,
          onSurface: Colors.black,
          surfaceTint: AppColors.primaryColor),

      indicatorColor: AppColors.primaryColor,
      // primaryColor: AppColors.primaryColor,
      // primarySwatch: convertColor(0xFF1C3A88),
      useMaterial3: true,
      // AppColors.primaryColor: AppColors.primaryColor,
      brightness: Brightness.light,
      // canvasColor: Colors.green,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
        // foregroundColor: Colors.green,
        // centerTitle: true,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontFamily: 'Montserrat',
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          shadowColor: AppColors.primaryColor,
          surfaceTintColor: AppColors.primaryColor,
          rangePickerBackgroundColor: Colors.red),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            textStyle: const TextStyle(
                fontFamily: 'Caros',
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.normal),
            minimumSize: const Size(double.infinity, 60),
            backgroundColor: AppColors.primaryColor),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          extendedTextStyle:
              TextStyle(fontWeight: FontWeight.bold, fontFamily: "Quicksand"),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.primaryColor,
          elevation: 5),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey.shade900,
          selectedLabelStyle:
              lightTextTheme.displayMedium!.copyWith(fontSize: 14),
          unselectedLabelStyle:
              lightTextTheme.displayMedium!.copyWith(fontSize: 14),
          type: BottomNavigationBarType.fixed),
      textTheme: lightTextTheme,
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.amber;
          }
          return null;
        }),
      ),
      chipTheme: const ChipThemeData(elevation: 0),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return AppColors.primaryColor;
          }
          return null;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.amber;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return Colors.amber;
          }
          return null;
        }),
      ),
    );
  }
}
