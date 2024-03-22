import 'package:flutter/material.dart';
import 'package:self_project/common/theme/abstract_theme_shadows.dart';
import 'package:self_project/common/theme/custom_theme.dart';
import 'package:self_project/common/theme/abstract_theme_colors.dart';

class CustomThemeHolder extends InheritedWidget {
  final AbstractThemeColors appColors;
  final AbstractThemeShadows appShadows;
  final CustomTheme theme;

  CustomThemeHolder({
    required Widget child,
    required this.theme,
    Key? key,
  })  : appColors = theme.appColors,
        appShadows = theme.appShadows,
        super(key: key, child: child);

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
