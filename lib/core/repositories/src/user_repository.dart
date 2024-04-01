import 'package:todos_by_bloc/core/services/dio/dio_service.dart';

final class UserRepository {
  static UserRepository _instance = UserRepository._();

  UserRepository._();

  factory UserRepository() => _instance;

  Future<Response> getMe() async => await DioService().get('/auth/me');
}
