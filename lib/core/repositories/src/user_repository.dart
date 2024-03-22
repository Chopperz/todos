import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_by_bloc/core/repositories/repositories.dart';
import 'package:todos_by_bloc/core/services/dio/dio_service.dart';

final class UserRepository {
  static UserRepository _instance = UserRepository._();

  UserRepository._();

  factory UserRepository() => _instance;

  Future<void> userLogIn({required String username, required String password}) async {
    final res = await DioService().post(
      '/auth/login',
      data: {
        'username': username,
        'password': password,
        'expiresInMins': 10,
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
    final pref = await SharedPreferences.getInstance();
    await pref.setString("user-token-key", res.data["token"]);
    await DioService.resetStatic();
  }

  Future<Response> getMe() async {
    final res = await DioService().get('/auth/me');

    print("Res: ${res.data}, ${res.statusCode}");
    return res;
  }
}
