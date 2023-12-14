import 'dart:convert';

import 'package:flutter_training/data/models/weather_request.dart';
import 'package:test/test.dart';

void main() {
  group('WeatherRequest#toJson', () {
    test(
      '正常なWeatherRequestをJSONにエンコードする場合_正常なJSONを返却する',
      () {
        // arrange
        const dateString = '2020-04-01T12:00:00+09:00';
        final weatherRequest = WeatherRequest(
          area: 'Tokyo',
          date: DateTime.parse(dateString).toLocal(),
        );

        // act
        final actual = jsonEncode(weatherRequest.toJson());

        // assert
        const expected = '{"area":"Tokyo","date":"2020-04-01T12:00:00.000"}';
        expect(actual, expected);
      },
    );
  });
}
