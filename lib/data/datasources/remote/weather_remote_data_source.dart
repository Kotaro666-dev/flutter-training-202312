import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_training/data/models/weather_request.dart';
import 'package:flutter_training/data/models/weather_response.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherResponse> fetchWeather({required WeatherRequest request});
  Future<WeatherResponse> syncFetchWeather({required WeatherRequest request});
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

  /// [YumemiWeather.syncFetchWeather]は内部で同期処理を行っているため、メインスレッドがブロックされる
  /// [compute]を使って、別isolateで処理を行うようにし、メインスレッドのブロックを防ぐ
  @override
  Future<WeatherResponse> syncFetchWeather({
    required WeatherRequest request,
  }) async {
    final jsonString = jsonEncode(request.toJson());
    final response = await compute(_yumemiWeather.syncFetchWeather, jsonString);
    final jsonObject = jsonDecode(response) as Map<String, dynamic>;
    return Future.value(WeatherResponse.fromJson(jsonObject));
  }
}
