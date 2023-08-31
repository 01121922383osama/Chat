import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.background,
    centerTitle: true,
    elevation: 0,
    scrolledUnderElevation: 1.0,
    iconTheme: IconThemeData(
      color: AppColors.white,
      shadows: [
        Shadow(
          color: Colors.white,
          blurRadius: 2.0,
          offset: Offset(1, 0),
        ),
      ],
    ),
    titleTextStyle: TextStyle(
      color: AppColors.white,
      fontSize: 22,
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      color: Colors.white,
    ),
    headlineLarge: TextStyle(
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      color: Colors.white,
    ),
    displayLarge: TextStyle(
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      color: Colors.white,
    ),
    labelLarge: TextStyle(
      color: Colors.white,
    ),
    labelMedium: TextStyle(
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(seedColor: AppColors.background),
  useMaterial3: true,
);
