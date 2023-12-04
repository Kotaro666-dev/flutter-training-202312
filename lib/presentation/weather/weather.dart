import 'package:flutter_training/core/exceptions/exceptions.dart';

enum Weather {
  sunny,
  cloudy,
  rainy;

  factory Weather.fromName(String name) {
    switch (name) {
      case 'sunny':
        return Weather.sunny;
      case 'cloudy':
        return Weather.cloudy;
      case 'rainy':
        return Weather.rainy;
      default:
        throw UnknownWeatherException('Unknown weather: $name');
    }
  }
}
