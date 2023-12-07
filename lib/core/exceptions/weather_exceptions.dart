/// Base Exception class
sealed class WeatherException implements Exception {}

/// Exception class for weather API
sealed class WeatherApiException extends WeatherException {}

class InvalidParameterException extends WeatherApiException {}

class UnknownWeatherException extends WeatherApiException {}

/// Exception class for system
sealed class SystemException extends WeatherException {
  SystemException({required this.message});

  final String message;

  @override
  String toString() {
    return message;
  }
}

class NetworkException extends SystemException {
  NetworkException({required super.message});
}

class UnexpectedException extends SystemException {
  UnexpectedException({required super.message});
}

/// Exception class for domain
sealed class DomainException extends WeatherException {
  DomainException({required this.message});

  final String message;

  @override
  String toString() {
    return message;
  }
}

class UndefinedWeatherException extends DomainException {
  UndefinedWeatherException({required super.message});
}
