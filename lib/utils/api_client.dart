import 'package:dio/dio.dart';

class ApiClient {
  static Dio create() {
    return Dio(
      BaseOptions(
        baseUrl: "https://api.tenrai.org/v1",
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );
  }
}
