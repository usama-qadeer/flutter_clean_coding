import 'package:flutter/foundation.dart';

class AppLogger {
  static void d(String message) {
    if (kDebugMode) debugPrint("🐞 $message");
  }

  static void i(String message) {
    debugPrint("ℹ️ $message");
  }

  static void w(String message) {
    debugPrint("⚠️ $message");
  }

  static void e(String message, [Object? error, StackTrace? st]) {
    debugPrint("❌ $message");
    if (kDebugMode && error != null) debugPrint("   error: $error");
    if (kDebugMode && st != null) debugPrint("   stack: $st");
  }

  /// Mask sensitive fields like password/token
  static Map<String, dynamic> maskSensitive(Map<String, dynamic> data) {
    final copy = Map<String, dynamic>.from(data);
    const keys = ['password', 'token', 'access_token', 'refresh_token'];
    for (final k in keys) {
      if (copy.containsKey(k)) copy[k] = "***";
    }
    return copy;
  }
}
