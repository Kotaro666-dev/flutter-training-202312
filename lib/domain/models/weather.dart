import 'package:flutter_training/core/exceptions/exceptions.dart';

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
    throw UnknownWeatherException('Unknown weather: $name');
  }
}
