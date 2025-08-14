class AppExceptions implements Exception {
  final _message;
  final _prefix;
  AppExceptions(this._message, this._prefix);

  @override
  String toString() {
    return "$_message$_prefix";
  }
}

class NoInternetException extends AppExceptions {
  NoInternetException(String? message)
      : super(message, "No Internet Exceptions");
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException(String? message)
      : super(message, "You dont have access to this");
}

class RequestTimeOutException extends AppExceptions {
  RequestTimeOutException(String? message) : super(message, "Request time out");
}

class FetchDataException extends AppExceptions {
  FetchDataException(String? message) : super(message, "");
}
