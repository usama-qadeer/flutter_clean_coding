import 'package:folder_stuture/core/bootstrap/app_bootstrap_vm.dart';
import 'package:folder_stuture/core/routes/routes_export.dart';

GoRouter createRouter(AuthState auth, AppBootstrapVM bootstrap) {
  bool isAuthRequired(String loc) =>
      loc == AppRoutes.branches || loc == AppRoutes.admin;

  return GoRouter(
    initialLocation: AppRoutes.splash,

    // ✅ router refresh when auth OR bootstrap changes
    refreshListenable: Listenable.merge([auth, bootstrap]),

    redirect: (context, state) {
      final loc = state.matchedLocation;

      // ✅ hold splash while auth checking OR (logged in but bootstrap not ready)
      final shouldHoldSplash =
          auth.checking || (auth.isLoggedIn && !bootstrap.ready);

      if (shouldHoldSplash) {
        return loc == AppRoutes.splash ? null : AppRoutes.splash;
      }

      final isSplash = loc == AppRoutes.splash;
      final isLogin = loc == AppRoutes.login;

      // ✅ not logged in
      if (!auth.isLoggedIn) {
        if (isSplash) return AppRoutes.login;

        if (isAuthRequired(loc)) {
          auth.setRedirectIfNull(loc);
          return AppRoutes.login;
        }

        return isLogin ? null : AppRoutes.login;
      }

      // ✅ logged in + bootstrap ready
      if (isSplash || isLogin) {
        return auth.consumeRedirectOrDefault(AppRoutes.branches);
      }

      // ✅ role guard
      if (loc == AppRoutes.admin && auth.role != UserRole.admin) {
        return AppRoutes.branches;
      }

      return null;
    },

    routes: [
      GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashScreen()),
      GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(
        path: AppRoutes.branches,
        builder: (_, _) => const BranchesScreen(),
      ),
      GoRoute(
        path: AppRoutes.admin,
        builder: (_, _) =>
            const Scaffold(body: Center(child: Text("Admin Panel"))),
      ),
    ],
  );
}
