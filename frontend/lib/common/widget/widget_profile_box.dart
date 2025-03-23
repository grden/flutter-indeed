import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../extension/extension_context.dart';
import 'widget_line.dart';
import 'widget_sizedbox.dart';
import '../../model/model_teacher.dart';
import '../../model/model_user.dart';
import '../../model/model_student.dart';

class InfoBox extends StatelessWidget {
  final String title;
  final Widget child;
  final bool canEdit;
  final bool accountType;

  const InfoBox(
      {super.key,
      required this.child,
      required this.title,
      required this.canEdit,
      required this.accountType});

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
                    onPressed: () {
                      GoRouter.of(context)
                          .pushNamed('edit-info', extra: accountType);
                    },
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
  final String gender;
  final int age;
  final List<dynamic> subjects;
  final String reply;
  final Teacher teacher;
  final String reviewer;
  final bool canEdit;

  const TeacherReviewBox(
      {super.key,
      required this.content,
      this.reply = "",
      required this.subjects,
      required this.teacher,
      required this.canEdit,
      required this.gender,
      required this.age,
      required this.reviewer});

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
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                if (canEdit) ...[
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed('new-reply',
                          extra: teacher, pathParameters: {'email': reviewer});
                    },
                    icon: Icon(
                      Icons.rate_review_outlined,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: gender != Gender.male.genderString
                        ? context.appColors.womanBadge
                        : context.appColors.manBadge),
                child: Center(
                  child: Text(
                    gender,
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
                age.toString(),
                style: TextStyle(
                    color: context.appColors.secondaryText,
                    fontSize: 19,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                ' ∙ ${subjects.join(', ')}',
                style: TextStyle(
                    color: context.appColors.secondaryText,
                    fontSize: 19,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          if (reply.isNotEmpty) ...[
            const Height(12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
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
                  const Height(12),
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

class StudentReviewBox extends StatelessWidget {
  final String content;
  final String displayName;
  final List<dynamic> subjects;
  final String reply;
  final Student student;
  final String reviewer;
  final bool canEdit;

  const StudentReviewBox(
      {super.key,
      required this.content,
      this.reply = "",
      required this.subjects,
      required this.student,
      required this.canEdit,
      required this.displayName,
      required this.reviewer});

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
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                if (canEdit) ...[
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed('new-reply',
                          extra: student, pathParameters: {'email': reviewer});
                    },
                    icon: Icon(
                      Icons.rate_review_outlined,
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName,
                style: TextStyle(
                    color: context.appColors.secondaryText,
                    fontSize: 19,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                ' ∙ ${subjects.join(', ')}',
                style: TextStyle(
                    color: context.appColors.secondaryText,
                    fontSize: 19,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          if (reply.isNotEmpty) ...[
            const Height(12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16)),
                  color: context.appColors.textFieldColor),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      student.user.name,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Height(12),
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
