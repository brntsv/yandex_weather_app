import 'package:flutter/material.dart';

class AppTheme {
  static final themeData = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
        color: AppColors.red,
        titleTextStyle: TxtStyles.titleText,
        actionsIconTheme: IconThemeData(color: Colors.black)),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    primaryColor: AppColors.red,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            width: 2,
            color: AppColors.red,
          )),
      filled: true,
      fillColor: AppColors.primaryDark,
    ),
  );
}

abstract class AppColors {
  static const red = Color(0xFFE0351A);
  static const redContent = Color(0xFFF05B44);

  static const backgroundDark = Color(0xFF212121);
  static const primaryDark = Color(0xFF424242);

  static const forecastText = Color(0xB1FFFFFF);
  static const greyText = Color(0x7EFFFFFF);
}

class TxtStyles {
  static const titleText = TextStyle(
      fontSize: 27,
      fontWeight: FontWeight.w400,
      color: AppColors.backgroundDark);
  static const bodyText =
      TextStyle(fontSize: 20, color: AppColors.forecastText);
  static const inputText = TextStyle(fontSize: 20, color: AppColors.greyText);
  static const orangeText =
      TextStyle(fontSize: 30, color: AppColors.redContent);
  static const orangeTextSmall =
      TextStyle(fontSize: 19, color: AppColors.greyText);
  static const tempMain = TextStyle(fontSize: 70, color: AppColors.redContent);
}
