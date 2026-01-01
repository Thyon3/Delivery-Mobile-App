import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thydelivery_mobileapp/services/api/api_client.dart';
import 'package:thydelivery_mobileapp/providers/api_provider.dart';

final orderApiProvider = Provider<OrderApi>((ref) {
  return OrderApi(ref.read(apiClientProvider));
});

class OrderApi {
  final ApiClient _client;

  OrderApi(this._client);

  Future<void> createOrder({
    required String restaurantId,
    required List<Map<String, dynamic>> items,
    required String deliveryAddressId,
    String paymentMethod = 'CASH', // CARD, CASH, WALLET
  }) async {
    try {
      await _client.dio.post('/orders', data: {
        'restaurantId': restaurantId,
        'items': items,
        'deliveryAddressId': deliveryAddressId,
        'paymentMethod': paymentMethod,
      });
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to place order';
    }
  }

  Future<List<dynamic>> getMyOrders() async {
    try {
      final response = await _client.dio.get('/orders/my-orders');
      return response.data['data']['items'] ?? [];
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to fetch orders';
    }
  }
}
