import 'package:dio/dio.dart';

abstract class BaseApiService {
  Future<dynamic> get(String url, {Map<String, String>? headers});
  Future<dynamic> post(
    String url, {
    Map<String, String>? headers,
    dynamic body,
  });
  Future<dynamic> postMultipart(
    String url, {
    Map<String, String>? headers,
    required FormData formData,
  });
}
