import 'dart:io';

import 'package:flutter_training/core/exceptions/weather_exceptions.dart';
import 'package:flutter_training/data/datasources/remote/weather_remote_data_source.dart';
import 'package:flutter_training/data/models/weather_request.dart';
import 'package:flutter_training/data/models/weather_response.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:flutter_training/domain/repositories/weather_repository.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

const String _sampleArea = 'tokyo';
final DateTime _sampleDate = DateTime.now().toLocal();

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({
    required WeatherRemoteDataSource weatherRemoteDataSource,
  }) : _weatherRemoteDataSource = weatherRemoteDataSource;

  final WeatherRemoteDataSource _weatherRemoteDataSource;

  @override
  Future<Weather> fetchWeather() async {
    try {
      // Note: リクエストパラメータは固定値で渡しているが、本来はユーザーが選択した値を渡す
      final response = await _weatherRemoteDataSource.fetchWeather(
        request: WeatherRequest(
          area: _sampleArea,
          date: _sampleDate,
        ),
      );
      return _toWeather(response);
    } on YumemiWeatherError catch (e) {
      switch (e) {
        case YumemiWeatherError.invalidParameter:
          throw InvalidParameterException();
        case YumemiWeatherError.unknown:
          throw UnknownWeatherException();
      }
    } on FormatException catch (e) {
      throw UndefinedWeatherException(message: e.toString());
    } on IOException catch (e) {
      throw NetworkException(message: e.toString());
    } on Exception catch (e) {
      throw UnexpectedException(message: e.toString());
    }
  }

  Weather _toWeather(WeatherResponse response) {
    final isValid = [
      response.weatherCondition,
      response.maxTemperature,
      response.minTemperature,
    ].every((e) => e != null);

    if (!isValid) {
      throw const FormatException('WeatherResponse is invalid');
    }

    final condition = WeatherCondition.from(response.weatherCondition!);
    return Weather(
      condition: condition,
      maxTemperature: response.maxTemperature!,
      minTemperature: response.minTemperature!,
    );
  }
}
