import '../../../core/network/base_api_service.dart';
import 'auth_model.dart';

class AuthApi {
  final BaseApiService apiService;
  AuthApi(this.apiService);

  Future<AuthModel> login(String email, String password) async {
    final response = await apiService.post<Map<String, dynamic>>(
      headers: null,
      '/login',
      body: {'email': email, 'password': password},
    );

    final data = response['data'];
    if (data is! Map<String, dynamic>) {
      throw Exception('Invalid response: data is missing or not an object');
    }

    return AuthModel.fromJson(data);
  }
}
