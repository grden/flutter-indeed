import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constant.dart';
import '../extension/extension_context.dart';
import 'widget_sizedbox.dart';
import 'widget_tap.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.appColors.backgroundColor,
      scrolledUnderElevation: 0,
      toolbarHeight: appBarHeight,
      actions: [
        Tap(
          onTap: () {
            context.push('/setting');
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.tune,
              size: 28,
              color: context.appColors.iconButton,
            ),
          ),
        ),
        const Width(16),
      ],
    );
  }
}
