import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_by_bloc/config/firebase/app_firebase.dart';
import 'package:todos_by_bloc/core/constants/app_constants.dart';
import 'package:todos_by_bloc/core/extensions/extensions.dart';
import 'package:todos_by_bloc/core/services/services.dart';

final class AuthRepository {
  static AuthRepository _instance = AuthRepository._();

  AuthRepository._();

  factory AuthRepository() => _instance;

  Future<bool> userLogIn() async {
    final res = await DioService().post(
      '/auth/login',
      data: {
        'username': "kminchelle",
        'password': "0lelplR",
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

  Future<String> refreshToken({String? userAccessToken}) async {
    final Response<dynamic> res = await DioService().post(
      "/auth/refresh",
      data: {
        "expiresInMins": 60,
      },
      options: Options(contentType: "application/json", headers: {
        if (userAccessToken.isNotEmptyOrNull) "Authorization": "Bearer $userAccessToken",
      }),
    );

    return res.data == null ? "" : res.data["token"];
  }

  Future<void> userLogout() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(USER_TOKEN_KEY);
    await DioService.resetStatic();
    await AppFirebase.instance.logout();
  }
}
