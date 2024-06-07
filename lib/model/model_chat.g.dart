// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatDataImpl _$$ChatDataImplFromJson(Map<String, dynamic> json) =>
    _$ChatDataImpl(
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      lastMsg: json['lastMsg'] as String,
      lastTime: _lastTimeFromJson(json['lastTime'] as Timestamp),
    );

Map<String, dynamic> _$$ChatDataImplToJson(_$ChatDataImpl instance) =>
    <String, dynamic>{
      'members': instance.members,
      'lastMsg': instance.lastMsg,
      'lastTime': instance.lastTime.toIso8601String(),
    };
