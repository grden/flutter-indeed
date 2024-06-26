import 'package:flutter/material.dart';

import 'abstract_theme_shadows.dart';
import 'custom_theme.dart';
import 'abstract_theme_colors.dart';

class CustomThemeHolder extends InheritedWidget {
  final AbstractThemeColors appColors;
  final AbstractThemeShadows appShadows;
  final CustomTheme theme;

  CustomThemeHolder({
    required super.child,
    required this.theme,
    super.key,
  })  : appColors = theme.appColors,
        appShadows = theme.appShadows;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static CustomThemeHolder of(BuildContext context) {
    CustomThemeHolder inherited =
        (context.dependOnInheritedWidgetOfExactType<CustomThemeHolder>())!;
    return inherited;
  }
}
