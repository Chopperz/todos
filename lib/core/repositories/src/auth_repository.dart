import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_by_bloc/core/constants/app_constants.dart';
import 'package:todos_by_bloc/core/services/services.dart';

final class AuthRepository {
  static AuthRepository _instance = AuthRepository._();

  AuthRepository._();

  factory AuthRepository() => _instance;

  Future<bool> userLogIn({required String username, required String password}) async {
    final res = await DioService().post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
        'expiresInMins': 60,
      },
      options: Options(
        headers: {
          'Content-Type': 'application/json',
        },
        validateStatus: (status) {
          return (status! < 505);
        },
      ),
    );

    if (res.statusCode == 200 && res.data["token"] != null) {
      final pref = await SharedPreferences.getInstance();
      await pref.setString(USER_TOKEN_KEY, res.data["token"]);
      await DioService.resetStatic();
      return true;
    } else {
      return false;
    }
  }

  Future<String> refreshToken() async {
    final res = await DioService().post(
      "/auth/refresh",
      data: {
        "expiresInMins": 60,
      },
      options: Options(
        contentType: "application/json",
      ),
    );

    return res.data["token"] ?? "";
  }

  Future<void> userLogout() async {
    final pref = await SharedPreferences.getInstance();
    await pref
      ..remove(USER_TOKEN_KEY)
      ..remove(IS_REMEMBER_ME_KEY);
    await DioService.resetStatic();
  }
}
