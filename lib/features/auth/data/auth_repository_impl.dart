import '../domain/auth_repository.dart';
import 'auth_api.dart';
import 'auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApi api;
  AuthRepositoryImpl(this.api);

  @override
  Future<AuthModel> login(String email, String password) {
    return api.login(email, password);
  }
}
