import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todos_by_bloc/core/constants/app_constants.dart';
import 'package:todos_by_bloc/core/repositories/src/auth_repository.dart';
import 'package:todos_by_bloc/main.dart';

export 'package:dio/dio.dart';

part 'interceptors/logger_interceptor.dart';

part 'dio_exception.dart';

part 'endpoints.dart';

class DioService {
  late Dio client;

  static DioService get instance => DioService._();

  BuildContext get context => navigatorKey.currentState!.context;

  static String? _token;

  String? get _userToken => _token;

  DioService._() {
    HiveCacheStore cacheStore = HiveCacheStore(
      appDirectoryPath,
      hiveBoxName: "dio_cache_storage",
    );

    final options = CacheOptions(
      store: cacheStore,
      // policy: CachePolicy.refresh,
      policy: CachePolicy.noCache,
      hitCacheOnErrorExcept: [400, 401, 404],
      maxStale: const Duration(days: 7),
      priority: CachePriority.normal,
      cipher: null,
      keyBuilder: CacheOptions.defaultCacheKeyBuilder,
      allowPostMethod: false,
    );

    final baseOptions = BaseOptions(
      baseUrl: Endpoints.baseUrl,
      connectTimeout: Endpoints.connectionTimeout,
      receiveTimeout: Endpoints.receiveTimeout,
      responseType: ResponseType.json,
      headers: {
        "Authorization": "Bearer $_userToken",
      },
    );

    client = Dio(
      baseOptions,
    );

    client.interceptors.addAll([
      DioCacheInterceptor(options: options),
      LoggerInterceptor(dio: client),
    ]);
  }

  factory DioService() => DioService._();

  static Future<void> initialize() async {
    final pref = await SharedPreferences.getInstance();
    _token = pref.getString("user-token-key");
  }

  static Future<void> resetStatic() async => await initialize();

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameter,
    Options? options,
  }) async {
    Future<Response> future = client.get(
      Endpoints.port + path,
      queryParameters: queryParameter,
      options: Options(
        contentType: "application/json",
        headers: options?.headers ??
            {
              "Accept": "application/json",
            },
      ),
    );
    try {
      return await future;
    } on DioException catch (err) {
      final exception = DioExceptionX.fromDioError(err);
      return err.response ??
          Response(
            requestOptions: err.requestOptions.copyWith(data: {"message": exception.errorMessage}),
          );
    } catch (_) {
      rethrow;
    }
  }

  Future<Response> post(
    String path, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    Future<Response> future = client.post(
      Endpoints.port + path,
      data: data,
      options: Options(
        headers: options?.headers ??
            {
              "Accept": "application/json",
            },
        validateStatus: (status) => status! < 500,
      ),
    );
    try {
      return await future;
    } on DioException catch (err) {
      final exception = DioExceptionX.fromDioError(err);
      return err.response ??
          Response(
            requestOptions: err.requestOptions.copyWith(data: {"message": exception.errorMessage}),
          );
    } catch (_) {
      rethrow;
    }
  }

  Future<Response> put(
    String path, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    Future<Response> future = client.put(
      Endpoints.port + path,
      data: data,
      options: Options(
        headers: options?.headers ??
            {
              "Accept": "application/json",
            },
      ),
    );
    try {
      return await future;
    } on DioException catch (err) {
      DioExceptionX.fromDioError(err);
      rethrow;
    } catch (_) {
      rethrow;
    }
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? data,
    Options? options,
  }) async {
    Future<Response> future = client.delete(
      Endpoints.port + path,
      data: data,
      options: Options(
        headers: options?.headers ??
            {
              "Accept": "application/json",
            },
      ),
    );
    try {
      return await future;
    } on DioException catch (err) {
      DioExceptionX.fromDioError(err);
      return err.response!;
    } catch (_) {
      rethrow;
    }
  }
}

extension DioResponseExtension on Response {
  bool get isSuccess {
    if (this.data != null) {
      return this.data["status"] == true &&
          this.data["code"] == "0000" &&
          this.data["message"] == "Success";
    }
    return false;
  }

  dynamic get objectValue => this.data["objectValue"];
}
