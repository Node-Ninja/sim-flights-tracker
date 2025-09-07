import 'package:flutter/material.dart';
import 'package:sim_flights_tracker/core/theme/colors.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: SftColors.primaryDark,
  primaryColor: SftColors.primary,
  appBarTheme: const AppBarTheme(
    color: SftColors.primary,
    foregroundColor: Colors.white,

  ),
  textTheme: TextTheme(
    titleSmall: const TextStyle(
      color: SftColors.lightGreen,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: const TextStyle(
      color: SftColors.lightGreen,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: const TextStyle(
      color: SftColors.lightGreen,
    ),
    bodySmall: const TextStyle(
      color: Colors.grey,
      fontSize: 14,
    ),
    labelSmall: TextStyle(
      color: SftColors.customGrey.withValues(alpha: 0.4)
    )
  ),
  cardTheme: CardThemeData(
    color: SftColors.primaryDark,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: SftColors.lightGreen.withValues(alpha: 0.5),
        strokeAlign: BorderSide.strokeAlignCenter,
        width: 1,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      backgroundColor: SftColors.lightOrange,
      foregroundColor: Colors.white
    )
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: SftColors.lightOrange,
    )
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: SftColors.lightGreen,
    circularTrackColor: Colors.transparent,
  ),
  iconTheme: const IconThemeData(
    color: SftColors.lightGreen,
    weight: 100,
  ),
  dividerTheme: DividerThemeData(
    color: SftColors.lightGreen.withValues(alpha: 0.3),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: SftColors.primaryDark,
  ),
  inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.only(top: 15),
      border: InputBorder.none,
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.transparent
          )
      ),
      enabledBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      disabledBorder: InputBorder.none
  ),
  bottomSheetTheme: BottomSheetThemeData(
    modalBarrierColor: SftColors.primaryDark.withValues(alpha: 0.8),
  ),
  useMaterial3: true
);

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: SftColors.customGrey,
    primaryColor: SftColors.primary,
    appBarTheme: const AppBarTheme(
      color: SftColors.primary,
      foregroundColor: Colors.white,

    ),
    textTheme: TextTheme(
        titleSmall: const TextStyle(
          color: SftColors.lightGreen,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: const TextStyle(
          color: SftColors.lightGreen,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: const TextStyle(
          color: SftColors.lightGreen,
        ),
        bodySmall: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        labelSmall: TextStyle(
            color: SftColors.customGrey.withValues(alpha: 0.4)
        )
    ),
    cardTheme: CardThemeData(
      color: SftColors.primaryDark,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: SftColors.lightGreen.withValues(alpha: 0.5),
          strokeAlign: BorderSide.strokeAlignCenter,
          width: 1,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            backgroundColor: SftColors.lightOrange,
            foregroundColor: Colors.white
        )
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: SftColors.lightOrange,
        )
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: SftColors.lightGreen,
      circularTrackColor: Colors.transparent,
    ),
    iconTheme: const IconThemeData(
      color: SftColors.lightGreen,
      weight: 100,
    ),
    dividerTheme: DividerThemeData(
      color: SftColors.lightGreen.withValues(alpha: 0.3),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: SftColors.primaryDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: SftColors.lightGreen),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: SftColors.customGrey.withValues(alpha: 0.3)),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: SftColors.customGrey),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
    useMaterial3: true
);
