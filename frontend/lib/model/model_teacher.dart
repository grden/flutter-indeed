import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:self_project/model/enums.dart';
import 'package:self_project/model/model_user.dart';

part 'model_teacher.freezed.dart';

part 'model_teacher.g.dart';

@unfreezed
sealed class Teacher with _$Teacher {
  factory Teacher({
    required final UserData user,
    required String displayName,
    required List<Subject> subjects,
    String? profileImagePath,
    String? univ,
    String? major,
    String? studentID,
    String? budget,
    //List<LectureMethod>? lectureMethods,
    String? info,
    String? experience,
  }) = _Teacher;

  factory Teacher.fromJson(Map<String, dynamic> json) =>
      _$TeacherFromJson(json);

  factory Teacher.fromFirestore(UserData user, Map<String, dynamic> json) =>
      Teacher(
        user: user,
        displayName: json['displayName'],
        subjects:
            json['subjects'].map<Subject>((e) => Subject.fromValue(e)).toList(),
        profileImagePath: json['profileImagePath'],
        univ: json['univ'],
        major: json['major'],
        studentID: json['studentID'],
        budget: json['budget'],
        info: json['info'],
      );
}
