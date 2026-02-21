import 'package:folder_stuture/core/bootstrap/app_bootstrap_vm.dart';
import 'package:folder_stuture/core/permissions/permission_vm.dart';
import 'package:folder_stuture/main_exports.dart';

Future<void> runMainApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalStorage.init();

  final apiService = NetworkApiService(
    baseUrl: AppConfig.baseUrl,
    tokenProvider: () async => AppLocalStorage.getUserToken(),
  );

  // =====================
  // AUTH FEATURE CHAIN
  // =====================
  final authApi = AuthApi(apiService);
  final authRepo = AuthRepositoryImpl(authApi);
  final loginUseCase = LoginUseCase(authRepo);

  // =====================
  // BRANCHES FEATURE CHAIN
  // =====================
  final branchesApi = BranchesApi(apiService);
  final branchesRepo = BranchesRepositoryImpl(branchesApi);
  final getBranchesUseCase = GetBranchesUseCase(branchesRepo);

  runApp(
    MyApp(loginUseCase: loginUseCase, getBranchesUseCase: getBranchesUseCase),
  );
}

class MyApp extends StatelessWidget {
  final LoginUseCase loginUseCase;
  final GetBranchesUseCase getBranchesUseCase;

  const MyApp({
    super.key,
    required this.loginUseCase,
    required this.getBranchesUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeVM()),
        ChangeNotifierProvider(create: (_) => AuthState()..init()),

        ChangeNotifierProvider(create: (_) => LoginVM(loginUseCase)),
        ChangeNotifierProvider(create: (_) => BranchesVM(getBranchesUseCase)),
        ChangeNotifierProvider(create: (_) => PermissionVM()),

        // ✅ Bootstrap depends on BranchesVM (+ add more VMs later)
        ChangeNotifierProxyProvider2<PermissionVM, BranchesVM, AppBootstrapVM>(
          create: (context) =>
              AppBootstrapVM(branchesVM: context.read<BranchesVM>()),
          update: (context, perm, branches, old) =>
              old ?? AppBootstrapVM(branchesVM: branches),
        ),
      ],
      child: Consumer3<ThemeVM, AuthState, AppBootstrapVM>(
        builder: (context, themeVM, auth, bootstrap, _) {
          final GoRouter router = createRouter(auth, bootstrap);

          return ScreenUtilInit(
            designSize: const Size(375, 812),
            splitScreenMode: true,
            builder: (context, child) => MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Folder Structure',
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              themeMode: themeVM.mode,
              routerConfig: router,
            ),
          );
        },
      ),
    );
  }
}
