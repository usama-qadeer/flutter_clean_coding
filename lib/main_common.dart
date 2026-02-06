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
      ],
      child: Consumer2<ThemeVM, AuthState>(
        builder: (context, themeVM, auth, _) {
          final GoRouter router = createRouter(auth);

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
