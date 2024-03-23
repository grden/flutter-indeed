import 'package:flutter/material.dart';

import 'package:self_project/main.dart';
import 'custom_theme_holder.dart';
import 'custom_theme.dart';

class CustomThemeApp extends StatefulWidget {
  final Widget child;

  const CustomThemeApp({super.key, required this.child});

  @override
  State<CustomThemeApp> createState() => _CustomThemeAppState();
}

class _CustomThemeAppState extends State<CustomThemeApp> {
  final CustomTheme theme = App.defaultTheme;

  @override
  Widget build(BuildContext context) {
    return CustomThemeHolder(
      theme: theme,
      child: widget.child,
    );
  }
}
