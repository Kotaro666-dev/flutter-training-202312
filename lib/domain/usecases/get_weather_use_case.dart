import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/repositories/weather_repository.dart';
import 'package:flutter_training/domain/result.dart';

class GetWeatherUseCase {
  GetWeatherUseCase({
    required WeatherRepository weatherRepository,
  }) : _weatherRepository = weatherRepository;

  final WeatherRepository _weatherRepository;

  Future<Result<Weather>> call() async {
    try {
      final response = await _weatherRepository.fetchWeather();
      return Success(data: response);
    } on Exception catch (e) {
      return Failure(exception: e);
    }
  }
}
