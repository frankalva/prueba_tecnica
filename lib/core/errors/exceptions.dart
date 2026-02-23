class ApiException implements Exception {
  final String message;
  ApiException([this.message = 'Error from the server']);

  @override
  String toString() => message;
}

class UnknownException implements Exception {
  final String message;
  final StackTrace stackTrace;
  UnknownException([this.message = 'Unknown Error', this.stackTrace = StackTrace.empty]);

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Error access to the local database']);

  @override
  String toString() => message;
}
