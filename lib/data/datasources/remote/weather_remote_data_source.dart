import 'package:flutter_training/data/models/weather_response.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherResponse> fetchWeather();
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl({
    required YumemiWeather yumemiWeather,
  }) : _yumemiWeather = yumemiWeather;

  final YumemiWeather _yumemiWeather;

  @override
  Future<WeatherResponse> fetchWeather() async {
    final response = _yumemiWeather.fetchSimpleWeather();
    return WeatherResponse.from(response: response);
  }
}
