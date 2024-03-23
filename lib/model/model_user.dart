import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_user.freezed.dart';
part 'model_user.g.dart';

DateTime _onlineTimeFromJson(Timestamp timestamp) => timestamp.toDate();

@unfreezed
sealed class UserData with _$UserData {
  factory UserData({
    required final String id,
    required final String name,
    required final Gender gender,
    required int age,
    required Location locations,
    required bool? accountType, //true = teacher, false = student
    required bool initialSetup,
    @JsonKey(fromJson: _onlineTimeFromJson) required DateTime onlineTime,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
}

enum Gender {
  @JsonValue('남') male(genderString: '남'),
  @JsonValue('여') female(genderString: '여');

  const Gender({required this.genderString});

  final String genderString;
}

enum Location {
  @JsonValue('서울') seoul(locationString: '서울'),
  @JsonValue('경기') gyeonggi(locationString: '경기');

  const Location({required this.locationString});

  final String locationString;
}
