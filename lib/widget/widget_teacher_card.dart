import 'package:flutter/material.dart';
import 'package:self_project/common/extension/extension_context.dart';
import 'package:self_project/object/object_profile.dart';
import 'package:self_project/object/object_teacher_profile.dart';
import 'package:self_project/common/widget/widget_sizedbox.dart';

class BuildTeacherCard extends StatelessWidget {
  final List<SimpleTeacherProfile> teacherProfiles;
  final int index;

  const BuildTeacherCard(this.teacherProfiles, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    final teacher = teacherProfiles[index];

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
                child: Image(
                  image: AssetImage(teacher.profileImagePath ??
                      'assets/image/default_profile.png'),
                ),
              ),
            ),
          ),
          const Height(8),
          Row(
            children: [
              Expanded(
                child: Text(
                  teacher.nickname,
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
                    color: teacher.profile.gender != Gender.male
                        ? context.appColors.womanBadge
                        : context.appColors.manBadge),
                child: Center(
                  child: Text(
                    teacher.profile.gender.genderString,
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
                '${teacher.profile.age}',
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
                ' ∙ ${teacher.profile.locations.map((e) => e.locationString).join(',')}',
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
