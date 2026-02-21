import 'dart:io';
import 'package:dio/dio.dart';
import '../error/app_exception.dart';
import 'base_api_service.dart';
import 'interceptors.dart';

class NetworkApiService implements BaseApiService {
  final Dio _dio;

  NetworkApiService({Dio? dio, String? baseUrl, TokenProvider? tokenProvider})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: baseUrl ?? '',
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 15),
              headers: const {'Accept': 'application/json'},
            ),
          ) {
    _dio.interceptors.add(AppInterceptors(tokenProvider: tokenProvider));
  }

  @override
  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: headers,
          validateStatus: (s) => s != null && s < 500,
        ),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (_) {
      throw const UnknownException("Unexpected error");
    }
  }

  @override
  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: body,
        options: Options(
          headers: headers,
          validateStatus: (s) => s != null && s < 500,
        ),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (_) {
      throw const UnknownException("Unexpected error");
    }
  }

  @override
  Future<dynamic> postMultipart(
    String url, {
    Map<String, String>? headers,
    required FormData formData,
  }) async {
    try {
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          headers: headers,
          validateStatus: (s) => s != null && s < 500,
        ),
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (_) {
      throw const UnknownException("Unexpected error");
    }
  }

  dynamic _handleResponse(Response response) {
    final code = response.statusCode ?? 0;

    // ✅ success
    if (code == 200 || code == 201) {
      return response.data; // dynamic
    }

    final data = response.data;
    final message = _extractMessage(data);

    if (code == 400 || code == 422) {
      throw ValidationException(message, code: code);
    }
    if (code == 401 || code == 403) {
      throw UnauthorizedException(
        message.isEmpty ? "Unauthorized" : message,
        code: code,
      );
    }

    throw ServerException("Server error ($code): $message", code: code);
  }

  String _extractMessage(dynamic data) {
    String message = "Something went wrong";

    if (data is Map) {
      message =
          (data['message']?.toString()) ??
          (data['error']?.toString()) ??
          (data['errors'] is Map
              ? (data['errors'].values.first is List
                    ? (data['errors'].values.first[0]?.toString())
                    : data['errors'].values.first?.toString())
              : null) ??
          message;
    } else if (data is String && data.isNotEmpty) {
      message = data;
    }

    return message;
  }

  AppException _handleDioError(DioException e) {
    if (e.error is SocketException) {
      return const NoInternetException("Please check your internet connection");
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const ServerException(
        "Connection timeout. Please try again later.",
      );
    }

    final res = e.response;
    if (res != null) {
      final code = res.statusCode;
      final msg = _extractMessage(res.data);

      if (code == 400 || code == 422) {
        return ValidationException(msg, code: code);
      }
      if (code == 401 || code == 403) {
        return UnauthorizedException(
          msg.isEmpty ? "Unauthorized" : msg,
          code: code,
        );
      }
      return ServerException(msg, code: code);
    }

    return UnknownException("Unexpected error: ${e.message}");
  }
}
