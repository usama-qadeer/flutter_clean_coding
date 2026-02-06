// ignore: library_prefixes

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:folder_stuture/features/auth/data/auth_state.dart';
import 'package:provider/provider.dart';

import '../../../core/error/app_exception.dart';
import '../data/auth_model.dart';
import '../domain/auth_usecase.dart';

class LoginVM extends ChangeNotifier {
  final LoginUseCase useCase;

  bool isLoading = false;
  String? error;
  AuthModel? user;

  LoginVM(this.useCase);

  Future<void> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    error = null;
    isLoading = true;
    notifyListeners();

    try {
      user = await useCase.execute(email, password);
      final AuthModel result = await useCase.execute(email, password);
      await context.read<AuthState>().setSession(
        token: result.token.toString(),
        role: result.role?.toString() ?? "user",
      );
    } on AppException catch (e) {
      error = e.message;
    } catch (ctx) {
      error = "Something went wrong";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
