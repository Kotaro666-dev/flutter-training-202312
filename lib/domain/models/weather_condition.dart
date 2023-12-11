import 'package:flutter_training/core/exceptions/weather_exceptions.dart';

enum WeatherCondition {
  sunny,
  cloudy,
  rainy;

  factory WeatherCondition.from(String condition) {
    for (final value in WeatherCondition.values) {
      if (value.name == condition) {
        return value;
      }
    }
    throw UndefinedWeatherException(message: 'Undefined weather: $condition');
  }
}
