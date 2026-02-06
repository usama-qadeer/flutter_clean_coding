import '../../../core/error/app_exception.dart';
import '../data/auth_model.dart';
import 'auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthModel> execute(String email, String password) {
    if (!email.contains('@')) throw const ValidationException('Invalid email');
    if (password.length < 6) {
      throw const ValidationException('Password too short');
    }
    return repository.login(email, password);
  }
}
