class UnknownWeatherException implements Exception {
  UnknownWeatherException(this.message);

  final String message;

  @override
  String toString() {
    return 'UnknownWeatherException: $message';
  }
}
