class HttpExceptions implements Exception {
  final String message;

  HttpExceptions(this.message);

  @override
  String toString() {
    return message;
  }
}
