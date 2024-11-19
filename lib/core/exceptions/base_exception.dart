class BaseException implements Exception {
  BaseException(this.message);
  final String message;

  @override
  String toString() {
    return message;
  }
}
