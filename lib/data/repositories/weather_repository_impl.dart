import 'package:flutter_training/data/datasources/remote/weather_remote_data_source.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/repositories/weather_repository.dart';

const _sampleArea = 'tokyo';

class WeatherRepositoryImpl implements WeatherRepository {
  WeatherRepositoryImpl({
    required WeatherRemoteDataSource weatherRemoteDataSource,
  }) : _weatherRemoteDataSource = weatherRemoteDataSource;

  final WeatherRemoteDataSource _weatherRemoteDataSource;

  @override
  Future<Weather> fetchWeather() async {
    // Note: area は固定値で渡しているが、本来はユーザーが選択した地域を渡す
    final response =
        await _weatherRemoteDataSource.fetchThrowsWeather(area: _sampleArea);
    return Weather.fromName(response.condition);
  }
}
