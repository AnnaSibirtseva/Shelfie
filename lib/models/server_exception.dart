class ServerException {
  late int _code;
  late String _message;
  late String _stackTrace;

  ServerException(this._code, this._message, this._stackTrace);

  factory ServerException.fromJson(dynamic json) {
    return ServerException(
      json['Code'] as int,
      json['Message'] as String,
      json['StackTrace'] as String,
    );
  }

  int getCode() {
    return _code;
  }

  String getMessage() {
    return _message;
  }

  String getStackTrace() {
    return _stackTrace;
  }
}
