import 'package:dio/dio.dart';
import '../logger/logger.dart';

typedef TokenProvider = Future<String?> Function();

class AppInterceptors extends Interceptor {
  final TokenProvider? tokenProvider;

  AppInterceptors({this.tokenProvider});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Attach token if available
    if (tokenProvider != null) {
      final token = await tokenProvider!.call();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }

    // Basic logging (dev-friendly)
    AppLogger.d("➡️ ${options.method} ${options.uri}");
    AppLogger.d("Headers: ${options.headers}");

    if (options.data is Map<String, dynamic>) {
      AppLogger.d("Body: ${AppLogger.maskSensitive(options.data)}");
    } else if (options.data != null) {
      AppLogger.d("Body: ${options.data}");
    }

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.d("✅ ${response.statusCode} ${response.requestOptions.uri}");
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.e(
      "⛔ ${err.requestOptions.method} ${err.requestOptions.uri} failed",
      err,
      err.stackTrace,
    );
    handler.next(err);
  }
}
