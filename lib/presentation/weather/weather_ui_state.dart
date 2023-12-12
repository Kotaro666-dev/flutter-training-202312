import 'package:flutter_training/domain/models/weather.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_ui_state.freezed.dart';

@freezed
class WeatherUiState with _$WeatherUiState {
  const factory WeatherUiState.initial() = _Initial;
  const factory WeatherUiState.success({required Weather weather}) = _Success;
  const factory WeatherUiState.error({required String message}) = _Error;
}
