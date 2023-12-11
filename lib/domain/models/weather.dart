import 'package:flutter_training/core/exceptions/weather_exceptions.dart';

class Weather {
  const Weather({
    required this.condition,
    required this.maxTemperature,
    required this.minTemperature,
  });

  final WeatherCondition condition;
  final int maxTemperature;
  final int minTemperature;
}

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
