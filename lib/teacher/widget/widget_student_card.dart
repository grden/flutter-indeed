import 'package:flutter/material.dart';

import '../../common/extension/extension_context.dart';
import '../../common/widget/widget_sizedbox.dart';
import '../../model/model_student.dart';
import '../../model/model_user.dart';

class BuildStudentCard extends StatelessWidget {
  final Student student;

  const BuildStudentCard(this.student, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: context.appColors.cardColor,
        boxShadow: [context.appShadows.cardShadow],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                student.user.name,
                style: TextStyle(
                    color: context.appColors.primaryText,
                    fontSize: 17,
                    fontWeight: FontWeight.w700),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
              ),
              const Width(8),
              Container(
                width: 18,
                height: 18,
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
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const Width(4),
              Text(
                '${student.user.age}',
                style: TextStyle(
                    color: context.appColors.secondaryText,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Height(8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  student.subjects.map((e) => e.subjectString).join(','),
                  style: TextStyle(
                    color: context.appColors.primaryText,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              ),
              Text(
                //' ∙ ${teacher.user.locations.map((e) => e.locationString).join(',')}',
                ' ∙ ${student.user.locations.locationString}',
                style: TextStyle(
                  color: context.appColors.secondaryText,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Height(8),
          //Text('${teacherProfiles[index].univ ?? ''} ${teacherProfiles[index].major ?? ''}'),
          TextField(
            style: const TextStyle(fontSize: 15),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              filled: true,
              fillColor: context.appColors.cardColor,
              suffixIcon:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.send)),
              iconColor: context.appColors.primaryColor,
              border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: context.appColors.secondaryText, width: 0.6),
                  borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: context.appColors.secondaryText, width: 0.6),
                  borderRadius: BorderRadius.circular(12)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: context.appColors.secondaryText, width: 0.6),
                  borderRadius: BorderRadius.circular(12)),
              hintText: '메시지를 보내보세요.',
              labelStyle: TextStyle(
                  fontSize: 17, color: context.appColors.secondaryText),
              errorStyle: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

String addString<T>(T? input, String backString, [String frontString = '']) {
  String output =
      input != null ? frontString + input.toString() + backString : '';
  return output;
}
