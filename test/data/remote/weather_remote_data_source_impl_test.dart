import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/data/datasources/remote/weather_remote_data_source.dart';
import 'package:flutter_training/data/models/weather_request.dart';
import 'package:flutter_training/data/models/weather_response.dart';
import 'package:flutter_training/data/providers/weather_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

@GenerateNiceMocks([MockSpec<YumemiWeather>()])
import 'weather_remote_data_source_impl_test.mocks.dart';

void main() {
  late MockYumemiWeather mockYumemiWeather;
  late ProviderContainer container;
  final request = WeatherRequest(
    area: 'tokyo',
    date: DateTime.now(),
  );

  setUp(
    () => {
      mockYumemiWeather = MockYumemiWeather(),
      container = ProviderContainer(
        overrides: [
          weatherRemoteDataSourceProvider.overrideWithValue(
            WeatherRemoteDataSourceImpl(yumemiWeather: mockYumemiWeather),
          ),
        ],
      ),
    },
  );

  group(
    'WeatherRemoteDataSourceImpl#fetchWeather(天気情報を取得する)',
    () => {
      test(
        'YumemiWeatherが正常なレスポンスを返却する場合_正常なレスポンスを返却する',
        () async {
          // arrange
          const returnValue = '''
            {
              "weather_condition": "sunny",
              "max_temperature": 30,
              "min_temperature": 20,
              "date": "2020-04-01T12:00:00+09:00"
            }
            ''';
          when(
            mockYumemiWeather.fetchWeather(any),
          ).thenReturn(
            returnValue,
          );

          // act
          final actual = await container
              .read(weatherRemoteDataSourceProvider)
              .fetchWeather(request: request);

          // // assert
          const expected = WeatherResponse(
            weatherCondition: 'sunny',
            maxTemperature: 30,
            minTemperature: 20,
            date: '2020-04-01T12:00:00+09:00',
          );
          expect(actual, expected);
        },
      ),
      test(
        'YumemiWeatherが不正なパラメータ例外を投げる場合_不正なパラメータ例外を投げる',
        () async {
          // arrange
          when(
            mockYumemiWeather.fetchWeather(any),
          ).thenThrow(
            YumemiWeatherError.invalidParameter,
          );

          // act/assert
          await expectLater(
            container
                .read(weatherRemoteDataSourceProvider)
                .fetchWeather(request: request),
            throwsA(
              isA<YumemiWeatherError>(),
            ),
          );
        },
      ),
      test(
        'YumemiWeatherが不明な天気情報例外を投げる場合_不明な天気情報例外を投げる',
        () async {
          // arrange
          when(
            mockYumemiWeather.fetchWeather(any),
          ).thenThrow(
            YumemiWeatherError.unknown,
          );

          // act/assert
          await expectLater(
            container
                .read(weatherRemoteDataSourceProvider)
                .fetchWeather(request: request),
            throwsA(
              isA<YumemiWeatherError>(),
            ),
          );
        },
      ),
    },
  );
}
