import 'package:flutter_training/domain/models/weather.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_ui_state.freezed.dart';

@freezed
class WeatherUiState with _$WeatherUiState {
  const factory WeatherUiState.initial() = _Initial;
  const factory WeatherUiState.loading({required Weather? weather}) = _Loading;
  const factory WeatherUiState.success({required Weather weather}) = _Success;
  const factory WeatherUiState.error({required String message}) = _Error;

  // Note: モデル内で getter やメソッドを定義する際にプライベートな空のコンストラクタを定義する必要がある
  // Ref: https://pub.dev/packages/freezed#adding-getters-and-methods-to-our-models
  const WeatherUiState._();

  Weather? get weatherOrNull => when(
        initial: () => null,
        loading: (weather) => weather,
        success: (weather) => weather,
        error: (_) => null,
      );

  bool get isLoading => maybeWhen(
        loading: (_) => true,
        orElse: () => false,
      );

  bool get canPop => maybeWhen(
        loading: (_) => false,
        orElse: () => true,
      );
}
