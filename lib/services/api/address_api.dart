import 'package:dio/dio.dart';
import 'package:thydelivery_mobileapp/services/api/api_client.dart';

class AddressApi {
  final ApiClient _client;

  AddressApi(this._client);

  Future<List<dynamic>> getAddresses() async {
    try {
      // Backend route: GET /users/addresses
      final response = await _client.dio.get('/users/addresses');
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to fetch addresses';
    }
  }

  Future<void> createAddress(Map<String, dynamic> addressData) async {
    try {
      // Backend route: POST /users/addresses
      await _client.dio.post('/users/addresses', data: addressData);
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to create address';
    }
  }

  Future<void> deleteAddress(String id) async {
    try {
      // Backend route: DELETE /users/addresses/:id
      await _client.dio.delete('/users/addresses/$id');
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to delete address';
    }
  }
}
