import 'dart:convert';

import 'package:flutter_training/data/models/weather_request.dart';
import 'package:flutter_training/data/models/weather_response.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherResponse> fetchWeather({required WeatherRequest request});
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  WeatherRemoteDataSourceImpl({
    required YumemiWeather yumemiWeather,
  }) : _yumemiWeather = yumemiWeather;

  final YumemiWeather _yumemiWeather;

  @override
  Future<WeatherResponse> fetchWeather({
    required WeatherRequest request,
  }) async {
    final jsonString = jsonEncode(request.toJson());
    final response = _yumemiWeather.fetchWeather(jsonString);
    final jsonObject = jsonDecode(response) as Map<String, dynamic>;
    return WeatherResponse.fromJson(jsonObject);
  }
}
