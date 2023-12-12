import 'package:flutter_training/data/providers/weather_provider.dart';
import 'package:flutter_training/data/repositories/weather_repository_impl.dart';
import 'package:flutter_training/domain/repositories/weather_repository.dart';
import 'package:flutter_training/domain/usecases/get_weather_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_provider.g.dart';

@riverpod
WeatherRepository weatherRepository(WeatherRepositoryRef ref) {
  final remoteDataSourceProvider = ref.watch(weatherRemoteDataSourceProvider);
  return WeatherRepositoryImpl(
    weatherRemoteDataSource: remoteDataSourceProvider,
  );
}

@riverpod
GetWeatherUseCase getWeatherUseCase(GetWeatherUseCaseRef ref) {
  final repositoryProvider = ref.watch(weatherRepositoryProvider);
  return GetWeatherUseCase(
    weatherRepository: repositoryProvider,
  );
}
