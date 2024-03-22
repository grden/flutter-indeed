import 'package:flutter/material.dart';

class ContactButton extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onTap;

  const ContactButton(
      {super.key,
      required this.textColor,
      required this.backgroundColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          color: backgroundColor, borderRadius: BorderRadius.circular(6)),
      child: Center(
        child: Text(
          '연락하기',
          style: TextStyle(fontSize: 19, color: textColor, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
