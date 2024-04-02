import 'package:flutter/material.dart';
import 'package:self_project/common/extension/extension_context.dart';

class InfoBox extends StatelessWidget {
  final Widget child;

  const InfoBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: context.appColors.cardColor,
        border: Border.all(color: context.appColors.lineColor)
      ),
      child: child,
    );
  }
}