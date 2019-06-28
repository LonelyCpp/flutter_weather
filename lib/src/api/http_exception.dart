/// represents an error state from an network API request
/// [code] represents the HTTP response code
/// string [message] reason if any
class HTTPException implements Exception {
  final int code;
  final String message;

  HTTPException(this.code, this.message) : assert(code != null);

  @override
  String toString() {
    return 'HTTPException{code: $code, message: $message}';
  }
}
