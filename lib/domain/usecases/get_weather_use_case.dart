import 'package:flutter/material.dart';
import 'package:flutter_training/core/exceptions/exceptions.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/repositories/weather_repository.dart';

class GetWeatherUseCase {
  GetWeatherUseCase({
    required WeatherRepository weatherRepository,
  }) : _weatherRepository = weatherRepository;

  final WeatherRepository _weatherRepository;

  Future<Weather?> call() async {
    try {
      return _weatherRepository.fetchWeather();
    } on UnknownWeatherException catch (e) {
      debugPrint(e.toString());
      return null;
    } on Exception catch (e) {
      // TODO Session5 #6 API のエラーハンドリングを実装する
      debugPrint(e.toString());
      return null;
    }
  }
}
