import '../../../../core/network/base_api_service.dart';

class AuthApi {
  final BaseApiService apiService;
  AuthApi(this.apiService);

  Future<dynamic> loginJson(String email, String password) {
    return apiService.post(
      '/login',
      body: {'email': email, 'password': password},
    );
  }
}
