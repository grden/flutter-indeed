import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widget_tap.dart';
import '../constant.dart';
import '../extension/extension_context.dart';
import 'widget_sizedbox.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: appBarHeight,
      color: context.appColors.backgroundColor,
      child: Row(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              CupertinoIcons.search,
              size: 28,
              color: context.appColors.iconButton,
            ),
          ),
          const Width(8),
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
      ),
    );
  }
}
