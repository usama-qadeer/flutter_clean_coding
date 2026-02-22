import 'package:folder_stuture/core/network/base_api_service.dart';

class AuthApi {
  final BaseApiService apiService;
  AuthApi(this.apiService);

  Future<Map<String, dynamic>> loginJson(String email, String password) async {
    final res = await apiService.post(
      '/login',
      body: {'email': email, 'password': password},
    );

    if (res is! Map<String, dynamic>) {
      throw Exception('Invalid response: not a JSON object');
    }
    return res;
  }
}
