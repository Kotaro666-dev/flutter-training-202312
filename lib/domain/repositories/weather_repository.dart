import 'package:flutter_training/domain/models/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather();
}
