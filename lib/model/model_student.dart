import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:self_project/model/enums.dart';
import 'package:self_project/model/model_user.dart';

part 'model_student.freezed.dart';

part 'model_student.g.dart';

@unfreezed
sealed class Student with _$Student {
  factory Student({
    required final UserData user,
    required List<Subject> subjects,
    required String info,
}) = _Student;

  factory Student.fromJson(Map<String, dynamic> json) =>
      _$StudentFromJson(json);

  factory Student.fromFirestore(
      UserData user, Map<String, dynamic> json) =>
      Student(
        user: user,
        subjects: json['subjects'].map<Subject>((e) => Subject.fromValue(e)).toList(),
        info: json['info'],
      );
}