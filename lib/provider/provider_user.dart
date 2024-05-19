import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:self_project/model/model_user.dart';
import 'package:self_project/model/mongo/user.dart';

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

/*
// FirebaseAuth instance에 접근하기 위한 provider
final firebaseAuthProvider =
Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);

// Firebase auth의 authStateChanges 메서드로 auth의 state 변화 확인하여 변화 시 Stream의 형태로 watch하기 위한 provider
final authStateChangesProvider = StreamProvider<User?>((ref) async* {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  // authStateChanges는 현재 User 혹은 null을 리턴 -> null check 필수
  yield* firebaseAuth.authStateChanges();
});

// Firestore에서 현재 User와 일치하는 'users' collection의 데이터 접근하기 위한 provider
final databaseProvider = Provider((ref) {
  final authUser = ref.watch(authStateChangesProvider);

  if (authUser.value?.uid != null) {
    // 현재 User의 uid 값과 일치하는 id를 갖는 user 찾아서 리턴 -> 리턴값은
    return db.collection('users').where('id', isEqualTo: authUser.value!.uid);
  }
  return null;
});
*/
