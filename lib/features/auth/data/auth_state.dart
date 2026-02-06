import 'package:flutter/foundation.dart';
import 'package:folder_stuture/core/utils/local_storage.dart';

enum AuthStatus { checking, authenticated, unauthenticated }

enum UserRole { user, admin }

class AuthState extends ChangeNotifier {
  AuthStatus _status = AuthStatus.checking;
  AuthStatus get status => _status;

  bool get checking => _status == AuthStatus.checking;
  bool get isLoggedIn => _status == AuthStatus.authenticated;

  UserRole _role = UserRole.user;
  UserRole get role => _role;

  String? _redirectLocation; // intended route (login ke baad yahin jana)
  String? get redirectLocation => _redirectLocation;

  Future<void> init() async {
    _status = AuthStatus.checking;
    notifyListeners();
    // 🔹 Dummy splash delay (5 sec)
    await Future.delayed(const Duration(seconds: 5));

    final token = AppLocalStorage.getUserToken();
    final roleStr = AppLocalStorage.getUserRole();

    if (token != null && token.isNotEmpty) {
      _status = AuthStatus.authenticated;
      _role = (roleStr == 'admin') ? UserRole.admin : UserRole.user;
    } else {
      _status = AuthStatus.unauthenticated;
      _role = UserRole.user;
    }

    notifyListeners();
  }

  Future<void> setSession({required String token, required String role}) async {
    await AppLocalStorage.saveUserToken(token);
    await AppLocalStorage.saveUserRole(role);

    _status = AuthStatus.authenticated;
    _role = (role == 'admin') ? UserRole.admin : UserRole.user;
    notifyListeners();
  }

  void setRedirectIfNull(String location) {
    _redirectLocation ??= location;
  }

  String consumeRedirectOrDefault(String fallback) {
    final loc = _redirectLocation;
    _redirectLocation = null;
    return loc ?? fallback;
  }

  Future<void> logout() async {
    await AppLocalStorage.clearUserToken();
    await AppLocalStorage.clearUserRole();
    _status = AuthStatus.unauthenticated;
    _role = UserRole.user;
    _redirectLocation = null;
    notifyListeners();
  }
}
