import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thydelivery_mobileapp/services/api/api_client.dart';
import 'package:thydelivery_mobileapp/services/api/address_api.dart';

final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());
final addressApiProvider = Provider<AddressApi>((ref) => AddressApi(ref.read(apiClientProvider)));
