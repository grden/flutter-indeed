import 'package:flutter/material.dart';

abstract class AbstractThemeShadows {
  const AbstractThemeShadows();

  BoxShadow get buttonShadow => const BoxShadow(
        offset: Offset(0, 7),
        blurRadius: 7,
        spreadRadius: 0,
        color: Colors.black,
      );

  BoxShadow get buttonShadowSmall;

  BoxShadow get textShadow;

  BoxShadow get defaultShadow;

  BoxShadow get thickTextShadow;

  BoxShadow get cardShadow => const BoxShadow(
        //offset: Offset(0, 0),
        blurRadius: 16,
        spreadRadius: 4,
        color: Color.fromARGB(12, 0, 0, 0),
      );
}
