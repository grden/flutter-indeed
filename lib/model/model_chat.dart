import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_chat.freezed.dart';
part 'model_chat.g.dart';

DateTime _lastTimeFromJson(Timestamp timestamp) => timestamp.toDate();

@unfreezed
sealed class ChatData with _$ChatData {
  factory ChatData({
    required List<String> members, // index 0 = teacher, index 1 = student
    required String lastMsg,
    @JsonKey(fromJson: _lastTimeFromJson) required DateTime lastTime,
  }) = _ChatData;

  factory ChatData.fromJson(Map<String, dynamic> json) =>
      _$ChatDataFromJson(json);
}
