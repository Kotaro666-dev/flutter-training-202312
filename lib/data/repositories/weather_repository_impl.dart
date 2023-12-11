import 'dart:io';

import 'package:flutter_training/core/exceptions/weather_exceptions.dart';
import 'package:flutter_training/data/datasources/remote/weather_remote_data_source.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/repositories/weather_repository.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

const _sampleArea = 'tokyo';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({
    required WeatherRemoteDataSource weatherRemoteDataSource,
  }) : _weatherRemoteDataSource = weatherRemoteDataSource;

  final WeatherRemoteDataSource _weatherRemoteDataSource;

  @override
  Future<Weather> fetchWeather() async {
    try {
      // Note: area は固定値で渡しているが、本来はユーザーが選択した地域を渡す
      final response =
          await _weatherRemoteDataSource.fetchThrowsWeather(area: _sampleArea);
      return Weather.fromName(response.condition);
    } on YumemiWeatherError catch (e) {
      switch (e) {
        case YumemiWeatherError.invalidParameter:
          throw InvalidParameterException();
        case YumemiWeatherError.unknown:
          throw UnknownWeatherException();
      }
    } on IOException catch (e) {
      throw NetworkException(message: e.toString());
    } on Exception catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }
}
