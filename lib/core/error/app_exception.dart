abstract class AppException implements Exception {
  final String message;
  final int? code;

  const AppException(this.message, {this.code});

  @override
  String toString() => message;
}

class NoInternetException extends AppException {
  const NoInternetException(super.message, {super.code});
}

class ValidationException extends AppException {
  const ValidationException(super.message, {super.code});
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(super.message, {super.code});
}

class ServerException extends AppException {
  const ServerException(super.message, {super.code});
}

class UnknownException extends AppException {
  const UnknownException(super.message, {super.code});
}
