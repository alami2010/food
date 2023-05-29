/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Foodies Full App Flutter
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2022-present initappz.
*/
import 'package:flutter/material.dart';

const typeTheme = Typography.whiteMountainView;

class ThemeProvider {
  static const appColor = Color(0xFFE73941);
  static const secondaryAppColor = Colors.blue;
  static const greenColor = Colors.green;
  static const whiteColor = Colors.white;
  static const blackColor = Color(0xFF333333);
  static const greyColor = Colors.grey;
  static const transParent = Colors.transparent;
  static const orangeColor = Colors.orange;
  static const titleStyle =
      TextStyle(fontSize: 14, fontFamily: 'regular', color: whiteColor);
}

TextTheme txtTheme = Typography.whiteMountainView.copyWith(
  bodyLarge: typeTheme.bodyLarge?.copyWith(fontSize: 16),
  bodyMedium: typeTheme.bodyLarge?.copyWith(fontSize: 14),
  displayLarge: typeTheme.bodyLarge?.copyWith(fontSize: 32),
  displayMedium: typeTheme.bodyLarge?.copyWith(fontSize: 28),
  displaySmall: typeTheme.bodyLarge?.copyWith(fontSize: 24),
  headlineMedium: typeTheme.bodyLarge?.copyWith(fontSize: 21),
  headlineSmall: typeTheme.bodyLarge?.copyWith(fontSize: 18),
  titleLarge: typeTheme.bodyLarge?.copyWith(fontSize: 16),
  titleMedium: typeTheme.bodyLarge?.copyWith(fontSize: 24),
  titleSmall: typeTheme.bodyLarge?.copyWith(fontSize: 21),
);

ThemeData light = ThemeData(
    fontFamily: 'regular',
    primaryColor: ThemeProvider.appColor,
    secondaryHeaderColor: ThemeProvider.secondaryAppColor,
    disabledColor: const Color(0xFFBABFC4),
    brightness: Brightness.light,
    hintColor: const Color(0xFF9F9F9F),
    cardColor: ThemeProvider.appColor,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: ThemeProvider.appColor)),
    textTheme: txtTheme,
    colorScheme: const ColorScheme.light(
            primary: ThemeProvider.appColor,
            secondary: ThemeProvider.secondaryAppColor)
        .copyWith(background: const Color(0xFFF3F3F3))
        .copyWith(error: const Color(0xFFE84D4F)));

ThemeData dark = ThemeData(
    fontFamily: 'regular',
    primaryColor: ThemeProvider.blackColor,
    secondaryHeaderColor: const Color(0xFF009f67),
    disabledColor: const Color(0xffa2a7ad),
    brightness: Brightness.dark,
    hintColor: const Color(0xFFbebebe),
    cardColor: Colors.black,
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: ThemeProvider.blackColor)),
    textTheme: txtTheme,
    colorScheme: const ColorScheme.dark(
            primary: ThemeProvider.blackColor, secondary: Color(0xFFffbd5c))
        .copyWith(background: const Color(0xFF343636))
        .copyWith(error: const Color(0xFFdd3135)));
