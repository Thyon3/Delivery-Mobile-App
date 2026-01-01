import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/foundation.dart';

class ApiClient {
  // Use 10.0.2.2 for Android Emulator, localhost for iOS/Web
  static const String baseUrl = 'http://10.0.2.2:5000/api/v1';
  
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ),
  );

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ApiClient() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token to headers
          final token = await _storage.read(key: 'accessToken');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          if (kDebugMode) {
            print('REQUEST[${options.method}] => PATH: ${options.path}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print('ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}');
          }
          return handler.next(e);
        },
      ),
    );
  }

  Dio get dio => _dio;

  Future<String?> getToken() => _storage.read(key: 'accessToken');
  Future<void> setToken(String token) => _storage.write(key: 'accessToken', value: token);
  Future<void> clearToken() => _storage.delete(key: 'accessToken');
}
