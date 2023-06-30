class Failure implements Exception {
  final int? statusCode;
  final String? message;

  Failure({
    this.statusCode,
    this.message,
  });
}
