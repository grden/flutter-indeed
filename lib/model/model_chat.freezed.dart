// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_chat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatData _$ChatDataFromJson(Map<String, dynamic> json) {
  return _ChatData.fromJson(json);
}

/// @nodoc
mixin _$ChatData {
  List<String> get members => throw _privateConstructorUsedError;
  set members(List<String> value) => throw _privateConstructorUsedError;
  String get lastMsg => throw _privateConstructorUsedError;
  set lastMsg(String value) => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _lastTimeFromJson)
  DateTime get lastTime => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _lastTimeFromJson)
  set lastTime(DateTime value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatDataCopyWith<ChatData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatDataCopyWith<$Res> {
  factory $ChatDataCopyWith(ChatData value, $Res Function(ChatData) then) =
      _$ChatDataCopyWithImpl<$Res, ChatData>;
  @useResult
  $Res call(
      {List<String> members,
      String lastMsg,
      @JsonKey(fromJson: _lastTimeFromJson) DateTime lastTime});
}

/// @nodoc
class _$ChatDataCopyWithImpl<$Res, $Val extends ChatData>
    implements $ChatDataCopyWith<$Res> {
  _$ChatDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? members = null,
    Object? lastMsg = null,
    Object? lastTime = null,
  }) {
    return _then(_value.copyWith(
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastMsg: null == lastMsg
          ? _value.lastMsg
          : lastMsg // ignore: cast_nullable_to_non_nullable
              as String,
      lastTime: null == lastTime
          ? _value.lastTime
          : lastTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatDataImplCopyWith<$Res>
    implements $ChatDataCopyWith<$Res> {
  factory _$$ChatDataImplCopyWith(
          _$ChatDataImpl value, $Res Function(_$ChatDataImpl) then) =
      __$$ChatDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> members,
      String lastMsg,
      @JsonKey(fromJson: _lastTimeFromJson) DateTime lastTime});
}

/// @nodoc
class __$$ChatDataImplCopyWithImpl<$Res>
    extends _$ChatDataCopyWithImpl<$Res, _$ChatDataImpl>
    implements _$$ChatDataImplCopyWith<$Res> {
  __$$ChatDataImplCopyWithImpl(
      _$ChatDataImpl _value, $Res Function(_$ChatDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? members = null,
    Object? lastMsg = null,
    Object? lastTime = null,
  }) {
    return _then(_$ChatDataImpl(
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastMsg: null == lastMsg
          ? _value.lastMsg
          : lastMsg // ignore: cast_nullable_to_non_nullable
              as String,
      lastTime: null == lastTime
          ? _value.lastTime
          : lastTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatDataImpl implements _ChatData {
  _$ChatDataImpl(
      {required this.members,
      required this.lastMsg,
      @JsonKey(fromJson: _lastTimeFromJson) required this.lastTime});

  factory _$ChatDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatDataImplFromJson(json);

  @override
  List<String> members;
  @override
  String lastMsg;
  @override
  @JsonKey(fromJson: _lastTimeFromJson)
  DateTime lastTime;

  @override
  String toString() {
    return 'ChatData(members: $members, lastMsg: $lastMsg, lastTime: $lastTime)';
  }

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatDataImplCopyWith<_$ChatDataImpl> get copyWith =>
      __$$ChatDataImplCopyWithImpl<_$ChatDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatDataImplToJson(
      this,
    );
  }
}

abstract class _ChatData implements ChatData {
  factory _ChatData(
          {required List<String> members,
          required String lastMsg,
          @JsonKey(fromJson: _lastTimeFromJson) required DateTime lastTime}) =
      _$ChatDataImpl;

  factory _ChatData.fromJson(Map<String, dynamic> json) =
      _$ChatDataImpl.fromJson;

  @override
  List<String> get members;
  set members(List<String> value);
  @override
  String get lastMsg;
  set lastMsg(String value);
  @override
  @JsonKey(fromJson: _lastTimeFromJson)
  DateTime get lastTime;
  @JsonKey(fromJson: _lastTimeFromJson)
  set lastTime(DateTime value);
  @override
  @JsonKey(ignore: true)
  _$$ChatDataImplCopyWith<_$ChatDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
