import 'package:flutter_training/core/exceptions/error_message.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/providers/weather_provider.dart';
import 'package:flutter_training/domain/result.dart';
import 'package:flutter_training/presentation/weather/weather_ui_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_page_state_provider.g.dart';

@riverpod
class WeatherPageState extends _$WeatherPageState {
  @override
  WeatherUiState build() {
    return const WeatherUiState.initial();
  }

  Future<void> fetchWeather() async {
    final result = await ref.watch(getWeatherUseCaseProvider).call();
    switch (result) {
      case Success<Weather>():
        state = WeatherUiState.success(
          weather: Weather(
            condition: result.data.condition,
            maxTemperature: result.data.maxTemperature,
            minTemperature: result.data.minTemperature,
          ),
        );
      case Failure<Weather>():
        final errrorMessage = getErrorMessage(e: result.exception);
        state = WeatherUiState.error(
          message: errrorMessage,
        );
    }
  }
}
