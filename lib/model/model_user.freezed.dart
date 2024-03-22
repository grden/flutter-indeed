// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return _UserData.fromJson(json);
}

/// @nodoc
mixin _$UserData {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  Gender get gender => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  set age(int value) => throw _privateConstructorUsedError;
  Location get locations => throw _privateConstructorUsedError;
  set locations(Location value) => throw _privateConstructorUsedError;
  bool? get accountType => throw _privateConstructorUsedError;
  set accountType(bool? value) =>
      throw _privateConstructorUsedError; //true = teacher, false = student
  @JsonKey(fromJson: _onlineTimeFromJson)
  DateTime get onlineTime =>
      throw _privateConstructorUsedError; //true = teacher, false = student
  @JsonKey(fromJson: _onlineTimeFromJson)
  set onlineTime(DateTime value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserDataCopyWith<UserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserDataCopyWith<$Res> {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) then) =
      _$UserDataCopyWithImpl<$Res, UserData>;
  @useResult
  $Res call(
      {String id,
      String name,
      Gender gender,
      int age,
      Location locations,
      bool? accountType,
      @JsonKey(fromJson: _onlineTimeFromJson) DateTime onlineTime});
}

/// @nodoc
class _$UserDataCopyWithImpl<$Res, $Val extends UserData>
    implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? gender = null,
    Object? age = null,
    Object? locations = null,
    Object? accountType = freezed,
    Object? onlineTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      locations: null == locations
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as Location,
      accountType: freezed == accountType
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as bool?,
      onlineTime: null == onlineTime
          ? _value.onlineTime
          : onlineTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserDataImplCopyWith<$Res>
    implements $UserDataCopyWith<$Res> {
  factory _$$UserDataImplCopyWith(
          _$UserDataImpl value, $Res Function(_$UserDataImpl) then) =
      __$$UserDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      Gender gender,
      int age,
      Location locations,
      bool? accountType,
      @JsonKey(fromJson: _onlineTimeFromJson) DateTime onlineTime});
}

/// @nodoc
class __$$UserDataImplCopyWithImpl<$Res>
    extends _$UserDataCopyWithImpl<$Res, _$UserDataImpl>
    implements _$$UserDataImplCopyWith<$Res> {
  __$$UserDataImplCopyWithImpl(
      _$UserDataImpl _value, $Res Function(_$UserDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? gender = null,
    Object? age = null,
    Object? locations = null,
    Object? accountType = freezed,
    Object? onlineTime = null,
  }) {
    return _then(_$UserDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      locations: null == locations
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as Location,
      accountType: freezed == accountType
          ? _value.accountType
          : accountType // ignore: cast_nullable_to_non_nullable
              as bool?,
      onlineTime: null == onlineTime
          ? _value.onlineTime
          : onlineTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserDataImpl implements _UserData {
  _$UserDataImpl(
      {required this.id,
      required this.name,
      required this.gender,
      required this.age,
      required this.locations,
      required this.accountType,
      @JsonKey(fromJson: _onlineTimeFromJson) required this.onlineTime});

  factory _$UserDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserDataImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final Gender gender;
  @override
  int age;
  @override
  Location locations;
  @override
  bool? accountType;
//true = teacher, false = student
  @override
  @JsonKey(fromJson: _onlineTimeFromJson)
  DateTime onlineTime;

  @override
  String toString() {
    return 'UserData(id: $id, name: $name, gender: $gender, age: $age, locations: $locations, accountType: $accountType, onlineTime: $onlineTime)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      __$$UserDataImplCopyWithImpl<_$UserDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserDataImplToJson(
      this,
    );
  }
}

abstract class _UserData implements UserData {
  factory _UserData(
      {required final String id,
      required final String name,
      required final Gender gender,
      required int age,
      required Location locations,
      required bool? accountType,
      @JsonKey(fromJson: _onlineTimeFromJson)
      required DateTime onlineTime}) = _$UserDataImpl;

  factory _UserData.fromJson(Map<String, dynamic> json) =
      _$UserDataImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  Gender get gender;
  @override
  int get age;
  set age(int value);
  @override
  Location get locations;
  set locations(Location value);
  @override
  bool? get accountType;
  set accountType(bool? value);
  @override //true = teacher, false = student
  @JsonKey(fromJson: _onlineTimeFromJson)
  DateTime get onlineTime; //true = teacher, false = student
  @JsonKey(fromJson: _onlineTimeFromJson)
  set onlineTime(DateTime value);
  @override
  @JsonKey(ignore: true)
  _$$UserDataImplCopyWith<_$UserDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
