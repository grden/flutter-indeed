import 'package:flutter/material.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_line.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';

class InfoBox extends StatelessWidget {
  final String title;
  final Widget child;

  const InfoBox({super.key, required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: context.appColors.cardColor,
          border: Border.all(color: context.appColors.lineColor)),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ),
          const Height(12),
          const Line(),
          const Height(12),
          child,
        ],),
    );
  }
}
