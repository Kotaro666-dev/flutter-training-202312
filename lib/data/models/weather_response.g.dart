// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, duplicate_ignore

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherResponseImpl _$$WeatherResponseImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$WeatherResponseImpl',
      json,
      ($checkedConvert) {
        final val = _$WeatherResponseImpl(
          weatherCondition:
              $checkedConvert('weather_condition', (v) => v as String?),
          maxTemperature: $checkedConvert('max_temperature', (v) => v as int?),
          minTemperature: $checkedConvert('min_temperature', (v) => v as int?),
          date: $checkedConvert('date', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'weatherCondition': 'weather_condition',
        'maxTemperature': 'max_temperature',
        'minTemperature': 'min_temperature'
      },
    );

Map<String, dynamic> _$$WeatherResponseImplToJson(
        _$WeatherResponseImpl instance) =>
    <String, dynamic>{
      'weather_condition': instance.weatherCondition,
      'max_temperature': instance.maxTemperature,
      'min_temperature': instance.minTemperature,
      'date': instance.date,
    };
