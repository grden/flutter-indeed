import 'package:flutter/material.dart';

typedef ColorProvider = Color Function();

abstract class AbstractThemeColors {
  const AbstractThemeColors();

  Color get backgroundColor => const Color.fromARGB(255, 245, 245, 245);

  Color get primaryColor => const Color.fromARGB(255, 23, 68, 159);

  //Color get tempColor => const Color.fromARGB(255, 0, 4, 40);

  Color get foregroundColor => const Color.fromARGB(153, 0, 0, 0);

  Color get errorColor => const Color(0xFFE23636);

  Color get successColor => const Color(0xFF82DD55);

  Color get textFieldColor => const Color.fromARGB(255, 233, 233, 238);

  Color get cardColor => const Color.fromARGB(255, 251, 251, 251);

  Color get lineColor => const Color.fromARGB(51, 0, 0, 0);

  Color get iconButton => const Color.fromARGB(230, 0, 0, 0);

  Color get iconButtonInactivate => secondaryText;

  Color get primaryText => const Color.fromARGB(230, 0, 0, 0);

  Color get secondaryText => foregroundColor;

  Color get inverseText => backgroundColor;

  Color get womanBadge => const Color.fromARGB(153, 255, 0, 0);

  Color get womanColor => const Color.fromARGB(255, 255, 0, 0);

  Color get manBadge => const Color.fromARGB(153, 0, 41, 255);

  Color get manColor => const Color.fromARGB(255, 0, 41, 255);
}
