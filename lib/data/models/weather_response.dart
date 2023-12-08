import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

@freezed
class WeatherResponse with _$WeatherResponse {
  const factory WeatherResponse({
    @JsonKey(name: 'weather_condition') String? weatherCondition,
    @JsonKey(name: 'max_temperature') int? maxTemperature,
    @JsonKey(name: 'min_temperature') int? minTemperature,
    @JsonKey(name: 'date') String? date,
  }) = _WeatherResponse;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}
