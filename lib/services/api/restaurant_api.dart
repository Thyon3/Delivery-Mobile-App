import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thydelivery_mobileapp/services/api/api_client.dart';
import 'package:thydelivery_mobileapp/providers/api_provider.dart';

final restaurantApiProvider = Provider<RestaurantApi>((ref) {
  return RestaurantApi(ref.read(apiClientProvider));
});

class RestaurantApi {
  final ApiClient _client;

  RestaurantApi(this._client);

  Future<List<dynamic>> getNearbyRestaurants({
    double? lat,
    double? lng,
    double radius = 5.0,
  }) async {
    try {
      final response = await _client.dio.get('/restaurants/nearby', queryParameters: {
        if (lat != null) 'latitude': lat,
        if (lng != null) 'longitude': lng,
        'radius': radius,
      });
      return response.data['data'] ?? [];
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to fetch restaurants';
    }
  }

  Future<Map<String, dynamic>> getRestaurantDetails(String id) async {
    try {
      final response = await _client.dio.get('/restaurants/$id');
      return response.data['data'];
    } on DioException catch (e) {
      throw e.response?.data['message'] ?? 'Failed to fetch restaurant details';
    }
  }
  
  // Fetch all menu items (if your backend supports it, or filter from restaurants)
  // For this app, we might want to just get "Popular" or similar.
  // Assuming we use the first restaurant found for the single-restaurant view style of the current UI.
}
