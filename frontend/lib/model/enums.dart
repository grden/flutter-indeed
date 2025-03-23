import 'package:freezed_annotation/freezed_annotation.dart';

enum Subject {
  @JsonValue('수학')
  math(subjectString: '수학'),
  @JsonValue('영어')
  english(subjectString: '영어'),
  @JsonValue('국어')
  korean(subjectString: '국어'),
  @JsonValue('과탐')
  science(subjectString: '과탐'),
  @JsonValue('사탐')
  society(subjectString: '사탐'),
  @JsonValue('논술')
  essay(subjectString: '논술'),
  @JsonValue('기타')
  others(subjectString: '기타');

  const Subject({required this.subjectString});

  final String subjectString;

  String getSubjectString(Subject subject) => subject.subjectString;

  static Subject fromValue(String json) => Subject.values.singleWhere((subject) => json == subject.subjectString);
}

enum LectureMethod {
  @JsonValue('온라인')
  online('온라인'),
  @JsonValue('오프라인')
  offline('오프라인');

  const LectureMethod(this.methodString);

  final String methodString;
}
