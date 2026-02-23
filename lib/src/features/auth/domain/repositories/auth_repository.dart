import '../../data/model/auth_model.dart';

abstract class AuthRepository {
  Future<AuthModel> login(String email, String password);
}
