import 'package:self_project/common/theme/abstract_theme_shadows.dart';
import 'package:self_project/common/theme/light_app_colors.dart';
import 'package:self_project/common/theme/abstract_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:self_project/common/theme/light_app_shadows.dart';

enum CustomTheme {
  lightTheme(LightAppColors(), LightAppShadows());
  //darkTheme(DarkAppColors());

  final AbstractThemeColors appColors;
  final AbstractThemeShadows appShadows;

  const CustomTheme(this.appColors, this.appShadows);

  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      //hoverColor: Colors.transparent,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      //brightness: Brightness.light,
      // textTheme: CustomGoogleFonts.diphylleiaTextTheme(
      //   ThemeData(brightness: Brightness.light).textTheme,
      // ),
      //colorScheme: ColorScheme.fromSeed(seedColor: CustomTheme.lightTheme.appColors.seedColor)
      fontFamily: 'Pretendard',
    );
  }
}
