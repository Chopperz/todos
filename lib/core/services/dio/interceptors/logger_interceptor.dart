part of '../dio_service.dart';

class LoggerInterceptor extends Interceptor {
  Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 75,
      colors: true,
      printEmojis: true,
      printTime: false,
    ),
  );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    final requestPath = '${options.baseUrl}${options.path}';
    logger.e('${options.method} request => $requestPath');
    logger.d('Error: ${err.error}, Message: ${err.message}');
    final errorMessage = DioExceptionX.fromDioError(err).toString();

    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      switch (errorMessage) {
        case "Authentication failed.":
          final pref = await SharedPreferences.getInstance();
          if (pref.containsKey("user-token-key")) pref.remove("user-token-key");
          navigatorKey.currentState!.pushReplacementNamed("/login");
          break;
        case "The authenticated user is not allowed to access the specified API endpoint.":
          navigatorKey.currentState!.pushReplacementNamed("/login");
          break;
        default:
      }

      return handler.reject(DioException(
        requestOptions: err.requestOptions,
        error: "The user has been deleted or the session is expired",
      ));
    }
    return handler.next(err);
    // return super.onError(err, handler);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl}${options.path}';
    logger.i('${options.method} request => $requestPath');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('StatusCode: ${response.statusCode}, Data: ${response.data}');
    if (response.statusCode == 200 && response.data != null) {
      return handler.next(response);
    }
    return handler.reject(
      DioException(
        requestOptions: response.requestOptions,
        error: 'The response is not in valid format',
      ),
    );
    // return super.onResponse(response, handler);
  }
}
