import 'package:flutter/material.dart';

typedef ColorProvider = Color Function();

abstract class AbstractThemeColors {
  const AbstractThemeColors();
  
  Color get backgroundColor => const Color.fromARGB(255, 245, 245, 245);

  Color get primaryColor => const Color.fromARGB(255, 0, 4, 40);

  Color get foregroundColor => const Color.fromARGB(153, 0, 0, 0);

  Color get errorColor => const Color.fromARGB(255, 198, 40, 40);

  Color get textFieldColor => const Color.fromARGB(255, 233, 233, 238);
  
  Color get cardColor => const Color.fromARGB(255, 251, 251, 251);

  Color get lineColor => const Color.fromARGB(51, 0, 0, 0);

  Color get iconButton => const Color.fromARGB(230, 0, 0, 0);

  Color get iconButtonInactivate => const Color.fromARGB(230, 0, 0, 0);

  Color get primaryText => const Color.fromARGB(230, 0, 0, 0);

  Color get secondaryText => const Color.fromARGB(153, 0, 0, 0);

  Color get inverseText => const Color.fromARGB(255, 245, 245, 245);

  Color get womanBadge => const Color.fromARGB(153, 255, 0, 0);

  Color get womanColor => const Color.fromARGB(255, 255, 0, 0);

  Color get manBadge => const Color.fromARGB(153, 0, 41, 255);

  Color get manColor => const Color.fromARGB(255, 0, 41, 255);
}
