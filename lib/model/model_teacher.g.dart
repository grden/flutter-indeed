// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_teacher.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeacherImpl _$$TeacherImplFromJson(Map<String, dynamic> json) =>
    _$TeacherImpl(
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
      displayName: json['displayName'] as String,
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => $enumDecode(_$SubjectEnumMap, e))
          .toList(),
      profileImagePath: json['profileImagePath'] as String? ??
          'assets/image/default_profile.png',
      univ: json['univ'] as String?,
      major: json['major'] as String?,
      studentID: json['studentID'] as String?,
      budget: json['budget'] as String?,
      lectureMethods: (json['lectureMethods'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$LectureMethodEnumMap, e))
          .toList(),
      info: json['info'] as String?,
      experience: json['experience'] as String?,
    );

Map<String, dynamic> _$$TeacherImplToJson(_$TeacherImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'displayName': instance.displayName,
      'subjects': instance.subjects.map((e) => _$SubjectEnumMap[e]!).toList(),
      'profileImagePath': instance.profileImagePath,
      'univ': instance.univ,
      'major': instance.major,
      'studentID': instance.studentID,
      'budget': instance.budget,
      'lectureMethods': instance.lectureMethods
          ?.map((e) => _$LectureMethodEnumMap[e]!)
          .toList(),
      'info': instance.info,
      'experience': instance.experience,
    };

const _$SubjectEnumMap = {
  Subject.math: 'math',
  Subject.english: 'english',
  Subject.korean: 'korean',
  Subject.science: 'science',
  Subject.society: 'society',
  Subject.essay: 'essay',
  Subject.others: 'others',
};

const _$LectureMethodEnumMap = {
  LectureMethod.online: 'online',
  LectureMethod.offline: 'offline',
};
