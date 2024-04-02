// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_student.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudentImpl _$$StudentImplFromJson(Map<String, dynamic> json) =>
    _$StudentImpl(
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
      subjects: (json['subjects'] as List<dynamic>)
          .map((e) => $enumDecode(_$SubjectEnumMap, e))
          .toList(),
      info: json['info'] as String,
    );

Map<String, dynamic> _$$StudentImplToJson(_$StudentImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'subjects': instance.subjects.map((e) => _$SubjectEnumMap[e]!).toList(),
      'info': instance.info,
    };

const _$SubjectEnumMap = {
  Subject.math: '수학',
  Subject.english: '영어',
  Subject.korean: '국어',
  Subject.science: '과탐',
  Subject.society: '사탐',
  Subject.essay: '논술',
  Subject.others: '기타',
};
