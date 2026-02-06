abstract class BaseApiService {
  Future<T> get<T>(String url, {Map<String, String>? headers});
  Future<T> post<T>(String url, {Map<String, String>? headers, dynamic body});
}
