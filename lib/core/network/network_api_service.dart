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
  Future<T> get<T>(String url, {Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(
        url,
        options: Options(
          headers: headers,
          validateStatus: (s) => s != null && s < 500,
        ),
      );
      return _handleResponse<T>(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw UnknownException("Unexpected error");
    }
  }

  @override
  Future<T> post<T>(
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
      return _handleResponse<T>(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (_) {
      throw UnknownException("Unexpected error");
    }
  }

  T _handleResponse<T>(Response response) {
    final code = response.statusCode ?? 0;

    // success
    if (code == 200 || code == 201) {
      return response.data as T;
    }

    // safe message extract
    String message = "Something went wrong";
    final data = response.data;

    if (data is Map) {
      message =
          (data['message']?.toString()) ??
          (data['errors'] is Map
              ? (data['errors'].values.first?[0]?.toString())
              : null) ??
          message;
    } else if (data is String && data.isNotEmpty) {
      message = data;
    }

    if (code == 400 || code == 422) {
      throw ValidationException(message, code: code);
    }
    if (code == 401 || code == 403) {
      throw UnauthorizedException("Unauthorized", code: code);
    }
    throw ServerException("Server error ($code): $message", code: code);
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
      final data = res.data;

      String msg = "Server error";
      if (data is Map && data['message'] != null) {
        msg = data['message'].toString();
      }
      if (code == 400 || code == 422) {
        return ValidationException(msg, code: code);
      }
      if (code == 401 || code == 403) {
        return UnauthorizedException(msg, code: code);
      }
      return ServerException(msg, code: code);
    }

    return UnknownException("Unexpected error: ${e.message}");
  }
}
