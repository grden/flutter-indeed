import 'dart:developer';

import 'package:grpc/service_api.dart';
import '../pb/login.pb.dart';
import '../pb/service.pb.dart';
import '../pb/signup.pb.dart';
import '../pb/user.pb.dart';
import 'grpc_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/mongo/user.dart';

class AuthService {
  static String? authToken;
  static UserModel? user;

  static Future<SharedPreferences> getSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  static Future<bool> isAuthAvailable() async {
    final sharedPreferences = await getSharedPreferences();
    authToken = sharedPreferences.getString('token');
    return authToken != null;
  }

  static Future<bool?> updateToken(String token) async {
    final sharedPreferences = await getSharedPreferences();
    authToken = token;
    return sharedPreferences.setString('token', token);
  }

  static Future<bool?> logout() async {
    final sharedPreferences = await getSharedPreferences();
    authToken = null;
    user = null;
    return sharedPreferences.remove('token');
  }

  static Future<UserModel?> login(String email, String password) async {
    try {
      final request = LoginRequestMessage(email: email, password: password);
      final response = await GrpcService.client.login(request);
      await updateToken(response.accessToken);
      user = UserModel(
          id: response.user.id,
          email: response.user.email,
          name: response.user.name);
      return user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  static Future<UserModel?> signup(
      String email, String password, String name) async {
    try {
      final request =
          SignupRequestMessage(email: email, password: password, name: name);
      final response = await GrpcService.client.signUp(request);
      return UserModel(
          id: response.user.id,
          email: response.user.email,
          name: response.user.name);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  static Future<UserModel?> getUser() async {
    try {
      final response = await GrpcService.client.getUser(
        EmptyRequest(),
        options: CallOptions(metadata: {'authorization': 'bearer $authToken'}),
      );
      user = UserModel(
          id: response.user.id,
          email: response.user.email,
          name: response.user.name);
      return user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  static Future<List<UserModel>> getUsers(
      {int pageNumber = 1, String? search}) async {
    final res = await GrpcService.client.getUsers(
        UsersListRequest(pageSize: 10, pageNumber: pageNumber, name: search),
        options: CallOptions(metadata: {'authorization': 'bearer $authToken'}));
    return res.users
        .map((e) => UserModel(id: e.id, email: e.email, name: e.name))
        .toList();
  }
}
