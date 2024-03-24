import 'package:flutter/material.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/model/model_teacher.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';
import 'package:self_project/model/model_user.dart';

class BuildTeacherCard extends StatelessWidget {
  final Teacher teacher;

  const BuildTeacherCard(this.teacher, {super.key});

  @override
  Widget build(BuildContext context) {
    //final teacher = teacherProfile;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: context.appColors.cardColor,
        boxShadow: [context.appShadows.cardShadow],
      ),
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: teacher.profileImagePath != null
                      ? Image(
                          image: NetworkImage(teacher.profileImagePath!),
                    fit: BoxFit.fill,
                        )
                      : const Image(
                          image:
                              AssetImage('assets/image/default_profile.png'))),
            ),
          ),
          const Height(8),
          Row(
            children: [
              Expanded(
                child: Text(
                  teacher.displayName,
                  style: TextStyle(
                      color: context.appColors.primaryText,
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
              const Width(4),
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: teacher.user.gender != Gender.male
                        ? context.appColors.womanBadge
                        : context.appColors.manBadge),
                child: Center(
                  child: Text(
                    teacher.user.gender.genderString,
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
                '${teacher.user.age}',
                style: TextStyle(
                    color: context.appColors.secondaryText,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Height(4),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${addString(teacher.univ, '대')} ${teacher.major ?? ''} ${addString(teacher.studentID, '학번')}',
                  style: TextStyle(
                    color: context.appColors.secondaryText,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.fade,
                  maxLines: 1,
                  softWrap: false,
                ),
              ),
            ],
          ),
          const Height(4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  teacher.subjects.map((e) => e.subjectString).join(','),
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
                ' ∙ ${teacher.user.locations.locationString}',
                style: TextStyle(
                  color: context.appColors.secondaryText,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                addString(teacher.budget, '만원', ' ∙ '),
                style: TextStyle(
                  color: context.appColors.secondaryText,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
          //Text('${teacherProfiles[index].univ ?? ''} ${teacherProfiles[index].major ?? ''}'),
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
