import 'package:flutter/material.dart';
import '../../error/app_exception.dart';
import 'app_dialogs.dart';

class AppExceptionHandler {
  AppExceptionHandler._();

  static Future<void> handle(
    BuildContext context,
    AppException e, {
    VoidCallback? onRetry,
    VoidCallback? onLogout,
  }) async {
    final msg = e.message.isNotEmpty ? e.message : "Something went wrong";

    if (e is NoInternetException) {
      return AppDialogs.failure(
        context: context,
        title: "No Internet",
        message: msg,
        buttonText: "Login Again",
        onButtonPressed: onRetry,
      );
    }

    if (e is ValidationException) {
      return AppDialogs.warning(context: context, message: msg);
    }

    if (e is UnauthorizedException) {
      return AppDialogs.failure(
        context: context,
        title: "Session Expired",
        message: msg,
        buttonText: "Login Again",
        onButtonPressed: onLogout,
      );
    }

    if (e is ServerException) {
      return AppDialogs.failure(
        context: context,
        message: msg,
        buttonText: "Retry",
        onButtonPressed: onRetry,
      );
    }

    return AppDialogs.error(context: context, message: msg);
  }
}
