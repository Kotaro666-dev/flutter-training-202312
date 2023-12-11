import 'package:flutter_training/domain/models/weather.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_ui_state.freezed.dart';

@freezed
class WeatherUiState with _$WeatherUiState {
  const factory WeatherUiState({
    required Weather? weather,
  }) = _WeatherUiState;

  static const initial = WeatherUiState(
    weather: null,
  );
}
