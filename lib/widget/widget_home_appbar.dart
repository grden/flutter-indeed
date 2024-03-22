import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:self_project/common/constant.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: appBarHeight,
      color: context.appColors.backgroundColor,
      child: Row(
        children: [
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              CupertinoIcons.search,
              size: 28,
            ),
          ),
          const Width(8),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Icon(
              Icons.settings_outlined,
              size: 28,
              color: context.appColors.iconButton,
            ),
          ),
          const Width(16),
        ],
      ),
    );
  }
}
