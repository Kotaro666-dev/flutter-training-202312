import 'dart:convert';

import 'package:flutter_training/data/models/weather_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test/test.dart';

void main() {
  group('WeatherResponse#fromJson', () {
    test(
      '正常なJSONデータをWeatherResponseにデコードする場合_正常なWeatherResponseを返却する',
      () {
        // arrange
        const jsonString = '''
          {
            "weather_condition": "sunny",
            "max_temperature": 30,
            "min_temperature": 20,
            "date": "2020-04-01T12:00:00+09:00"
          }
        ''';

        // act
        final jsonObject = jsonDecode(jsonString) as Map<String, dynamic>;
        final actual = WeatherResponse.fromJson(jsonObject);

        // assert
        const expected = WeatherResponse(
          weatherCondition: 'sunny',
          maxTemperature: 30,
          minTemperature: 20,
          date: '2020-04-01T12:00:00+09:00',
        );
        expect(actual, expected);
      },
    );

    test(
      '空のJSONデータをWeatherResponseにデコードする場合_フィールドが空のWeatherResponseを返却する',
      () {
        // arrange
        const jsonString = '''
          {}
        ''';

        // act
        final jsonObject = jsonDecode(jsonString) as Map<String, dynamic>;
        final actual = WeatherResponse.fromJson(jsonObject);

        // assert
        const expected = WeatherResponse();
        expect(actual, expected);
      },
    );

    test(
        'weather_condition フィールドに文字列型ではない値を含むJSONデータをWeatherResponseにデコードする場合_例外が発生する',
        () {
      // arrange
      const jsonString = '''
        {
            "weather_condition": 123,
            "max_temperature": 30,
            "min_temperature": 20,
            "date": "2020-04-01T12:00:00+09:00"
          }
      ''';

      // act/assert
      final jsonObject = jsonDecode(jsonString) as Map<String, dynamic>;
      expect(
        () => WeatherResponse.fromJson(jsonObject),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test(
        'max_temperature フィールドに整数ではない値を含むJSONデータをWeatherResponseにデコードする場合_例外が発生する',
        () {
      // arrange
      const jsonString = '''
        {
            "weather_condition": "sunny",
            "max_temperature": "hot",
            "min_temperature": 20,
            "date": "2020-04-01T12:00:00+09:00"
          }
      ''';

      // act/assert
      final jsonObject = jsonDecode(jsonString) as Map<String, dynamic>;
      expect(
        () => WeatherResponse.fromJson(jsonObject),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test(
        'min_temperature フィールドに整数ではない値を含むJSONデータをWeatherResponseにデコードする場合_例外が発生する',
        () {
      // arrange
      const jsonString = '''
        {
            "weather_condition": "sunny",
            "max_temperature": 30,
            "min_temperature": "cold",
            "date": "2020-04-01T12:00:00+09:00"
          }
      ''';

      // act/assert
      final jsonObject = jsonDecode(jsonString) as Map<String, dynamic>;
      expect(
        () => WeatherResponse.fromJson(jsonObject),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test('date フィールドに文字列ではない値を含むJSONデータをWeatherResponseにデコードする場合_例外が発生する', () {
      // arrange
      const jsonString = '''
        {
            "weather_condition": "sunny",
            "max_temperature": 30,
            "min_temperature": "cold",
            "date": 20200401120000
          }
      ''';

      // act/assert
      final jsonObject = jsonDecode(jsonString) as Map<String, dynamic>;
      expect(
        () => WeatherResponse.fromJson(jsonObject),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });

    test(
        'temperature フィールドに文字列型の整数値を含むJSONデータをWeatherResponseにデコードする場合_例外が発生する',
        () {
      // arrange
      const jsonString = '''
          {
            "weather_condition": "sunny",
            "max_temperature": "30",
            "min_temperature": "20",
            "date": "2020-04-01T12:00:00+09:00"
          }
        ''';

      // act/assert
      final jsonObject = jsonDecode(jsonString) as Map<String, dynamic>;
      expect(
        () => WeatherResponse.fromJson(jsonObject),
        throwsA(isA<CheckedFromJsonException>()),
      );
    });
  });
}
