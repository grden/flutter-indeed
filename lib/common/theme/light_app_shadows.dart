import 'package:flutter/material.dart';

import 'abstract_theme_shadows.dart';

class LightAppShadows extends AbstractThemeShadows {
  const LightAppShadows();

  @override
  BoxShadow get buttonShadow => const BoxShadow(
        offset: Offset(4, 4),
        blurRadius: 5,
        color: Color.fromARGB(255, 227, 227, 227),
      );
}
