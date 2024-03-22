part of 'dio_service.dart';

class Endpoints {
  Endpoints._();

  static final String baseUrl = dotenv.env["BASE_URL"] ?? "";

  static const Duration receiveTimeout = const Duration(seconds: 5);

  static const Duration connectionTimeout = const Duration(seconds: 3);

  static const String port = '';
}
