import 'package:flutter/foundation.dart';
import 'package:flutter_training/core/exceptions/weather_exceptions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';

@freezed
class Weather with _$Weather {
  const factory Weather({
    required WeatherCondition condition,
    required int maxTemperature,
    required int minTemperature,
  }) = _Weather;
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
