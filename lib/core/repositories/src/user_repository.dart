import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_by_bloc/core/repositories/repositories.dart';
import 'package:todos_by_bloc/core/services/dio/dio_service.dart';

final class UserRepository {
  static UserRepository _instance = UserRepository._();

  UserRepository._();

  factory UserRepository() => _instance;

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
      await pref.setString("user-token-key", res.data["token"]);
      await DioService.resetStatic();
      return true;
    } else {
      return false;
    }
  }

  Future<Response> getMe() async => await DioService().get('/auth/me');
}
