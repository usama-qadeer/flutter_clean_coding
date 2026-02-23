import 'package:folder_stuture/core/routes/routes_export.dart';

class RouteGuard {
  static bool isProtected(String? route) {
    return route == AppRoutes.branches;
  }

  static String? redirect(AuthState auth, String? targetRoute) {
    // splash always allowed
    if (targetRoute == AppRoutes.splash) return null;

    // not logged in + trying protected => go login
    if (!auth.isLoggedIn && isProtected(targetRoute)) {
      return AppRoutes.login;
    }

    // logged in + trying login => go branches
    if (auth.isLoggedIn && targetRoute == AppRoutes.login) {
      return AppRoutes.branches;
    }

    return null;
  }
}
