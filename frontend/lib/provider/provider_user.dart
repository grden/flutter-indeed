import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

import '../model/model_user.dart';
import '../model/mongo/user.dart';

/// FirebaseAuth, FirebaseFirestore의 user 정보에 대한 provider

final FirebaseFirestore db = FirebaseFirestore.instance;

// userCredential에 접근하기 위한 provider, 로그인 시 초기화 -> userCredential.user 프로퍼티를 통해 User에 접근
final userCredentialProvider = StateProvider<UserCredential?>((ref) => null);

final mongoUserProvider = StateProvider<UserModel?>((ref) => null);

final accountTypeProvider = StateProvider<bool?>((ref) => null);

final firestoreUserDbProvider = StateProvider((ref) {
  final mongoUser = ref.watch(mongoUserProvider);
  final firestoreUserDb = db
      .collection('users')
      .doc(mongoUser?.email)
      .withConverter(
          fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
          toFirestore: (userData, _) => userData.toJson());
  return firestoreUserDb;
});

// firestore에서 usercredential에 해당하는 사용자 가져와 UserData에 저장
// 후에 asyncvalue 리턴하는 streamprovider로 변경
final userDatabaseProvider = StateProvider((ref) {
  final userCredential = ref.watch(userCredentialProvider);
  final userDatabase = db
      .collection('users')
      .doc(userCredential?.user?.email)
      .withConverter(
          fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
          toFirestore: (userData, _) => userData.toJson());
  return userDatabase;
});
