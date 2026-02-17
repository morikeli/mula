import 'package:flutter/material.dart';
import 'package:mula/core/theme/color_scheme.dart';
import 'package:mula/core/theme/colors.dart';
import 'package:mula/core/theme/theme_data/elevated_btn_theme.dart';
import 'package:pinput/pinput.dart';

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

  // pinput theme
  static PinTheme defaultPinTheme(BuildContext context) => PinTheme(
    width: 72,
    height: 64,
    textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
  );
}
