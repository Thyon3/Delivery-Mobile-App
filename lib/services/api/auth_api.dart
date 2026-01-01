import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thydelivery_mobileapp/providers/api_provider.dart';
import 'package:thydelivery_mobileapp/services/api/api_client.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(ref.read(apiClientProvider));
});

class AuthApi {
  final ApiClient _client;

  AuthApi(this._client);

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _client.dio.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      return response.data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Login failed';
    }
  }

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final response = await _client.dio.post('/auth/register', data: {
        'email': email,
        'password': password,
        'firstName': firstName,
        'lastName': lastName,
        'role': 'CUSTOMER',
      });
      return response.data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Registration failed';
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    try {
      final response = await _client.dio.get('/users/profile');
      return response.data;
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to profile';
    }
  }

  Future<void> saveDeviceToken(String token) async {
    try {
      await _client.dio.post('/users/device-token', data: {'token': token});
    } catch (_) {
      // Ignore errors for token saving, it's background
    }
  }
}
