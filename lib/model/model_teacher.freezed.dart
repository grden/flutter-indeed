// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_teacher.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Teacher _$TeacherFromJson(Map<String, dynamic> json) {
  return _Teacher.fromJson(json);
}

/// @nodoc
mixin _$Teacher {
  UserData get user => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  set displayName(String value) => throw _privateConstructorUsedError;
  List<Subject> get subjects => throw _privateConstructorUsedError;
  set subjects(List<Subject> value) => throw _privateConstructorUsedError;
  String get profileImagePath => throw _privateConstructorUsedError;
  set profileImagePath(String value) => throw _privateConstructorUsedError;
  String? get univ => throw _privateConstructorUsedError;
  set univ(String? value) => throw _privateConstructorUsedError;
  String? get major => throw _privateConstructorUsedError;
  set major(String? value) => throw _privateConstructorUsedError;
  String? get studentID => throw _privateConstructorUsedError;
  set studentID(String? value) => throw _privateConstructorUsedError;
  String? get budget => throw _privateConstructorUsedError;
  set budget(String? value) => throw _privateConstructorUsedError;
  List<LectureMethod>? get lectureMethods => throw _privateConstructorUsedError;
  set lectureMethods(List<LectureMethod>? value) =>
      throw _privateConstructorUsedError;
  String? get info => throw _privateConstructorUsedError;
  set info(String? value) => throw _privateConstructorUsedError;
  String? get experience => throw _privateConstructorUsedError;
  set experience(String? value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeacherCopyWith<Teacher> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeacherCopyWith<$Res> {
  factory $TeacherCopyWith(Teacher value, $Res Function(Teacher) then) =
      _$TeacherCopyWithImpl<$Res, Teacher>;
  @useResult
  $Res call(
      {UserData user,
      String displayName,
      List<Subject> subjects,
      String profileImagePath,
      String? univ,
      String? major,
      String? studentID,
      String? budget,
      List<LectureMethod>? lectureMethods,
      String? info,
      String? experience});

  $UserDataCopyWith<$Res> get user;
}

/// @nodoc
class _$TeacherCopyWithImpl<$Res, $Val extends Teacher>
    implements $TeacherCopyWith<$Res> {
  _$TeacherCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? displayName = null,
    Object? subjects = null,
    Object? profileImagePath = null,
    Object? univ = freezed,
    Object? major = freezed,
    Object? studentID = freezed,
    Object? budget = freezed,
    Object? lectureMethods = freezed,
    Object? info = freezed,
    Object? experience = freezed,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserData,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      subjects: null == subjects
          ? _value.subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as List<Subject>,
      profileImagePath: null == profileImagePath
          ? _value.profileImagePath
          : profileImagePath // ignore: cast_nullable_to_non_nullable
              as String,
      univ: freezed == univ
          ? _value.univ
          : univ // ignore: cast_nullable_to_non_nullable
              as String?,
      major: freezed == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String?,
      studentID: freezed == studentID
          ? _value.studentID
          : studentID // ignore: cast_nullable_to_non_nullable
              as String?,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as String?,
      lectureMethods: freezed == lectureMethods
          ? _value.lectureMethods
          : lectureMethods // ignore: cast_nullable_to_non_nullable
              as List<LectureMethod>?,
      info: freezed == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as String?,
      experience: freezed == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserDataCopyWith<$Res> get user {
    return $UserDataCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TeacherImplCopyWith<$Res> implements $TeacherCopyWith<$Res> {
  factory _$$TeacherImplCopyWith(
          _$TeacherImpl value, $Res Function(_$TeacherImpl) then) =
      __$$TeacherImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {UserData user,
      String displayName,
      List<Subject> subjects,
      String profileImagePath,
      String? univ,
      String? major,
      String? studentID,
      String? budget,
      List<LectureMethod>? lectureMethods,
      String? info,
      String? experience});

  @override
  $UserDataCopyWith<$Res> get user;
}

/// @nodoc
class __$$TeacherImplCopyWithImpl<$Res>
    extends _$TeacherCopyWithImpl<$Res, _$TeacherImpl>
    implements _$$TeacherImplCopyWith<$Res> {
  __$$TeacherImplCopyWithImpl(
      _$TeacherImpl _value, $Res Function(_$TeacherImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
    Object? displayName = null,
    Object? subjects = null,
    Object? profileImagePath = null,
    Object? univ = freezed,
    Object? major = freezed,
    Object? studentID = freezed,
    Object? budget = freezed,
    Object? lectureMethods = freezed,
    Object? info = freezed,
    Object? experience = freezed,
  }) {
    return _then(_$TeacherImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserData,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      subjects: null == subjects
          ? _value.subjects
          : subjects // ignore: cast_nullable_to_non_nullable
              as List<Subject>,
      profileImagePath: null == profileImagePath
          ? _value.profileImagePath
          : profileImagePath // ignore: cast_nullable_to_non_nullable
              as String,
      univ: freezed == univ
          ? _value.univ
          : univ // ignore: cast_nullable_to_non_nullable
              as String?,
      major: freezed == major
          ? _value.major
          : major // ignore: cast_nullable_to_non_nullable
              as String?,
      studentID: freezed == studentID
          ? _value.studentID
          : studentID // ignore: cast_nullable_to_non_nullable
              as String?,
      budget: freezed == budget
          ? _value.budget
          : budget // ignore: cast_nullable_to_non_nullable
              as String?,
      lectureMethods: freezed == lectureMethods
          ? _value.lectureMethods
          : lectureMethods // ignore: cast_nullable_to_non_nullable
              as List<LectureMethod>?,
      info: freezed == info
          ? _value.info
          : info // ignore: cast_nullable_to_non_nullable
              as String?,
      experience: freezed == experience
          ? _value.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TeacherImpl implements _Teacher {
  _$TeacherImpl(
      {required this.user,
      required this.displayName,
      required this.subjects,
      this.profileImagePath = 'assets/image/default_profile.png',
      this.univ,
      this.major,
      this.studentID,
      this.budget,
      this.lectureMethods,
      this.info,
      this.experience});

  factory _$TeacherImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeacherImplFromJson(json);

  @override
  final UserData user;
  @override
  String displayName;
  @override
  List<Subject> subjects;
  @override
  @JsonKey()
  String profileImagePath;
  @override
  String? univ;
  @override
  String? major;
  @override
  String? studentID;
  @override
  String? budget;
  @override
  List<LectureMethod>? lectureMethods;
  @override
  String? info;
  @override
  String? experience;

  @override
  String toString() {
    return 'Teacher(user: $user, displayName: $displayName, subjects: $subjects, profileImagePath: $profileImagePath, univ: $univ, major: $major, studentID: $studentID, budget: $budget, lectureMethods: $lectureMethods, info: $info, experience: $experience)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TeacherImplCopyWith<_$TeacherImpl> get copyWith =>
      __$$TeacherImplCopyWithImpl<_$TeacherImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeacherImplToJson(
      this,
    );
  }
}

abstract class _Teacher implements Teacher {
  factory _Teacher(
      {required final UserData user,
      required String displayName,
      required List<Subject> subjects,
      String profileImagePath,
      String? univ,
      String? major,
      String? studentID,
      String? budget,
      List<LectureMethod>? lectureMethods,
      String? info,
      String? experience}) = _$TeacherImpl;

  factory _Teacher.fromJson(Map<String, dynamic> json) = _$TeacherImpl.fromJson;

  @override
  UserData get user;
  @override
  String get displayName;
  set displayName(String value);
  @override
  List<Subject> get subjects;
  set subjects(List<Subject> value);
  @override
  String get profileImagePath;
  set profileImagePath(String value);
  @override
  String? get univ;
  set univ(String? value);
  @override
  String? get major;
  set major(String? value);
  @override
  String? get studentID;
  set studentID(String? value);
  @override
  String? get budget;
  set budget(String? value);
  @override
  List<LectureMethod>? get lectureMethods;
  set lectureMethods(List<LectureMethod>? value);
  @override
  String? get info;
  set info(String? value);
  @override
  String? get experience;
  set experience(String? value);
  @override
  @JsonKey(ignore: true)
  _$$TeacherImplCopyWith<_$TeacherImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
