import 'package:dio/dio.dart';

class DioClient {
  const DioClient._();

  static Dio create() {
    return Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
      ),
    );
  }
}
