import 'package:flutter_training/core/exceptions/weather_exceptions.dart';

enum Weather {
  sunny,
  cloudy,
  rainy;

  factory Weather.fromName(String name) {
    for (final value in Weather.values) {
      if (value.name == name) {
        return value;
      }
    }
    throw UndefinedWeatherException(message: 'Undefined weather: $name');
  }
}
