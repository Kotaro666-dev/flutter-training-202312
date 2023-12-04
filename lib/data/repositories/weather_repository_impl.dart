import 'package:flutter_training/data/datasources/remote/weather_remote_data_source.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({
    required WeatherRemoteDataSource weatherRemoteDataSource,
  }) : _weatherRemoteDataSource = weatherRemoteDataSource;

  final WeatherRemoteDataSource _weatherRemoteDataSource;

  @override
  Future<Weather> fetchWeather() async {
    final response = await _weatherRemoteDataSource.fetchWeather();
    return Weather.fromName(response.condition);
  }
}
