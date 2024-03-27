import 'package:todos_by_bloc/core/services/dio/dio_service.dart';

final class HomeRepository {
  static HomeRepository _instance = HomeRepository._();

  HomeRepository._();

  factory HomeRepository() => _instance;
  
  Future<List<dynamic>?> getCategories() async {
    final res = await DioService().get("/products/categories");
    return res.data;
  }
}