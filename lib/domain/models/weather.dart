import 'package:flutter/foundation.dart';
import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather.freezed.dart';

@freezed
class Weather with _$Weather {
  const factory Weather({
    required WeatherCondition condition,
    required int maxTemperature,
    required int minTemperature,
  }) = _Weather;
}
