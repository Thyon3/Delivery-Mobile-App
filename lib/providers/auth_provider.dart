import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thydelivery_mobileapp/models/user.dart';
import 'package:thydelivery_mobileapp/services/api/auth_api.dart';
import 'package:thydelivery_mobileapp/providers/api_provider.dart';
import 'package:thydelivery_mobileapp/services/api/api_client.dart';

class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;

  AuthState({this.user, this.isLoading = false, this.error});
  
  bool get isAuthenticated => user != null;
  
  AuthState copyWith({User? user, bool? isLoading, String? error}) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthApi _authApi;
  final ApiClient _apiClient;

  AuthNotifier(this._authApi, this._apiClient) : super(AuthState()) {
    checkAuth();
  }

  Future<void> checkAuth() async {
    final token = await _apiClient.getToken();
    if (token == null) return;
    
    try {
      final response = await _authApi.getProfile();
      final data = response['data'];
      final user = User.fromJson(data);
      state = AuthState(user: user);
    } catch (_) {
      await _apiClient.clearToken();
      state = AuthState();
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _authApi.login(email, password);
      // Access 'data' field from the response body
      final data = response['data'];
      
      if (data == null) throw 'Invalid response from server';
      
      final user = User.fromJson(data['user']);
      final token = data['accessToken'];
      
      await _apiClient.setToken(token);
      
      state = AuthState(user: user);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  Future<bool> register(String email, String password, String firstName, String lastName) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _authApi.register(
        email: email, 
        password: password,
        firstName: firstName,
        lastName: lastName,
      );
      final data = response['data'];
      
      if (data == null) throw 'Invalid response from server';

      final user = User.fromJson(data['user']);
      final token = data['accessToken'];
      
      await _apiClient.setToken(token);
      
      state = AuthState(user: user);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }
  
  Future<void> logout() async {
    await _apiClient.clearToken();
    state = AuthState();
  }
  
  void submitDeviceToken(String token) {
    _authApi.saveDeviceToken(token);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.watch(authApiProvider),
    ref.watch(apiClientProvider),
  );
});
