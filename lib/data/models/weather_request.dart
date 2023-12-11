import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_request.freezed.dart';
part 'weather_request.g.dart';

@freezed
class WeatherRequest with _$WeatherRequest {
  const factory WeatherRequest({
    @JsonKey(name: 'area') required String area,
    @JsonKey(name: 'date') required DateTime date,
  }) = _WeatherRequest;

  factory WeatherRequest.fromJson(Map<String, dynamic> json) =>
      _$WeatherRequestFromJson(json);
}
