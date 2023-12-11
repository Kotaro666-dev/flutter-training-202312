import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_ui_state.freezed.dart';

@freezed
class WeatherUiState with _$WeatherUiState {
  const factory WeatherUiState({
    required String minTemperature,
    required String maxTemperature,
    WeatherCondition? condition,
  }) = _WeatherUiState;

  static const initial = WeatherUiState(
    minTemperature: '**',
    maxTemperature: '**',
  );
}
