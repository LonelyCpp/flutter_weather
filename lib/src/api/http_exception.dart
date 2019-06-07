class HTTPException implements Exception {
  final int code;
  final String message;

  HTTPException(this.code, this.message) : assert(code != null);

  @override
  String toString() {
    return 'HTTPException{code: $code, message: $message}';
  }

}
