import 'package:flutter_training/data/datasources/remote/weather_remote_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather_provider.g.dart';

@riverpod
WeatherRemoteDataSource weatherRemoteDataSource(
  WeatherRemoteDataSourceRef ref,
) {
  return WeatherRemoteDataSourceImpl(
    yumemiWeather: YumemiWeather(),
  );
}
