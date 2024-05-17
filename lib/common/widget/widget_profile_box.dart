import 'package:flutter/material.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/common/widget/widget_line.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:self_project/model/model_student.dart';
import 'package:self_project/model/model_teacher.dart';
import 'package:self_project/model/model_user.dart';

class InfoBox extends StatelessWidget {
  final String title;
  final Widget child;
  final bool canEdit;

  const InfoBox(
      {super.key,
      required this.child,
      required this.title,
      required this.canEdit});

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
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w700),
                ),
                if (canEdit) ...[
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit_outlined,
                      color: context.appColors.secondaryText,
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                ]
              ],
            ),
          ),
          const Height(12),
          const Line(),
          const Height(12),
          child,
        ],
      ),
    );
  }
}

class XPBox extends StatelessWidget {
  final String subject;
  final String age;
  final String date;
  final String period;
  final bool canEdit;

  const XPBox(
      {super.key,
      required this.subject,
      required this.age,
      required this.date,
      required this.period,
      required this.canEdit});

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
            child: Row(
              children: [
                Text(
                  "$subject, $age",
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.w700),
                ),
                if (canEdit) ...[
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit_outlined,
                      color: context.appColors.secondaryText,
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.close,
                        color: context.appColors.secondaryText),
                    visualDensity: VisualDensity.compact,
                  )
                ]
              ],
            ),
          ),
          const Height(12),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  date,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const Width(12),
                Text(
                  period,
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: context.appColors.secondaryText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherReviewBox extends StatelessWidget {
  final String content;
  final String subject;
  final String reply;
  final Teacher teacher;
  final Student student;
  final bool canEdit;

  const TeacherReviewBox(
      {super.key,
      required this.content,
      required this.student,
      required this.reply,
      required this.subject,
      required this.teacher,
      required this.canEdit});

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
            child: Row(
              children: [
                Text(
                  content,
                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                if (canEdit) ...[
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.edit_outlined,
                      color: context.appColors.secondaryText,
                    ),
                    visualDensity: VisualDensity.compact,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.report_gmailerrorred_outlined,
                        color: context.appColors.secondaryText),
                    visualDensity: VisualDensity.compact,
                  )
                ]
              ],
            ),
          ),
          const Height(12),
          const Line(),
          const Height(12),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: student.user.gender != Gender.male
                          ? context.appColors.womanBadge
                          : context.appColors.manBadge),
                  child: Center(
                    child: Text(
                      student.user.gender.genderString,
                      style: TextStyle(
                        color: context.appColors.cardColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const Width(4),
                Text(
                  '${student.user.age} ∙ ',
                  style: TextStyle(
                      color: context.appColors.secondaryText,
                      fontSize: 19,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  subject,
                  style: TextStyle(
                      color: context.appColors.secondaryText,
                      fontSize: 19,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          if (reply.isNotEmpty) ...[
            const Height(12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.appColors.textFieldColor),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      teacher.displayName,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Height(16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      reply,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            )
          ]
        ],
      ),
    );
  }
}
