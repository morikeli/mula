import 'package:flutter/material.dart';
import 'package:mula/core/theme/color_scheme.dart';
import 'package:mula/core/theme/colors.dart';
import 'package:mula/core/theme/theme_data/elevated_btn_theme.dart';

import 'theme_data/input_decoration_theme_data.dart';
import 'theme_data/text_theme_data.dart';

class MulaAppTheme {
  MulaAppTheme._();

  static ThemeData lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    colorScheme: MulaAppColorScheme.colorSchemeLight,
    dividerColor: kSecondaryColor,
    elevatedButtonTheme: MulaAppElevatedButtonTheme.elevatedButtonLightTheme,
    inputDecorationTheme: MulaAppInputDecorationTheme.inputDecorationLightTheme,
    scaffoldBackgroundColor: kScaffoldBgLightColor,
    textTheme: MulaAppTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    colorScheme: MulaAppColorScheme.colorSchemeDark,
    dividerColor: Colors.black,
    elevatedButtonTheme: MulaAppElevatedButtonTheme.elevatedButtonDarkTheme,
    inputDecorationTheme: MulaAppInputDecorationTheme.inputDecorationDarkTheme,
    scaffoldBackgroundColor: kScaffoldBgDarkcolor,
    textTheme: MulaAppTextTheme.darkTextTheme,
  );
}
