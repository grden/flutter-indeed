// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserDataImpl _$$UserDataImplFromJson(Map<String, dynamic> json) =>
    _$UserDataImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      age: json['age'] as int,
      locations: $enumDecode(_$LocationEnumMap, json['locations']),
      accountType: json['accountType'] as bool?,
      initialSetup: json['initialSetup'] as bool,
      onlineTime: _onlineTimeFromJson(json['onlineTime'] as Timestamp),
    );

Map<String, dynamic> _$$UserDataImplToJson(_$UserDataImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'gender': _$GenderEnumMap[instance.gender]!,
      'age': instance.age,
      'locations': _$LocationEnumMap[instance.locations]!,
      'accountType': instance.accountType,
      'initialSetup': instance.initialSetup,
      'onlineTime': instance.onlineTime.toIso8601String(),
    };

const _$GenderEnumMap = {
  Gender.male: '남',
  Gender.female: '여',
};

const _$LocationEnumMap = {
  Location.seoul: '서울',
  Location.gyeonggi: '경기',
};
