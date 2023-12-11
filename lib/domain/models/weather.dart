// 保存時の自動整形でfoundationが消えないように警告を消している
// ignore: unused_import, directives_ordering
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
    required DateTime date,
  }) = _Weather;
}
