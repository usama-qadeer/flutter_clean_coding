import '../../domain/repositories/auth_repository.dart';
import '../sources/auth_api.dart';
import '../model/auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi api;
  AuthRepositoryImpl(this.api);

  @override
  Future<AuthModel> login(String email, String password) async {
    final res = await api.loginJson(email, password);

    if (res is! Map<String, dynamic>) {
      throw Exception('Invalid response: not a JSON object');
    }

    final data = res['data'];
    if (data is! Map<String, dynamic>) {
      throw Exception('Invalid response: data missing or not an object');
    }

    return AuthModel.fromJson(data);
  }
}
