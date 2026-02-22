import '../domain/auth_repository.dart';
import 'auth_api.dart';
import 'auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi api;
  AuthRepositoryImpl(this.api);

  @override
  Future<AuthModel> login(String email, String password) async {
    final json = await api.loginJson(email, password);
    final data = json['data'];
    if (data is! Map<String, dynamic>) {
      throw Exception('Invalid response: data missing');
    }
    return AuthModel.fromJson(data);
  }
}
