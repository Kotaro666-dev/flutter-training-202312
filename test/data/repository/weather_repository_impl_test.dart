import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/core/exceptions/weather_exceptions.dart';
import 'package:flutter_training/data/datasources/remote/weather_remote_data_source.dart';
import 'package:flutter_training/data/models/weather_response.dart';
import 'package:flutter_training/data/providers/weather_provider.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:flutter_training/domain/providers/weather_provider.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

@GenerateNiceMocks([MockSpec<WeatherRemoteDataSource>()])
import 'weather_repository_impl_test.mocks.dart';

void main() {
  ProviderContainer createContainer(
    MockWeatherRemoteDataSource mockWeatherRemoteDataSource,
  ) {
    // Create a ProviderContainer, and optionally allow specifying parameters.
    final container = ProviderContainer(
      overrides: [
        weatherRemoteDataSourceProvider.overrideWithValue(
          mockWeatherRemoteDataSource,
        ),
      ],
    );

    // When the test ends, dispose the container.
    addTearDown(container.dispose);

    return container;
  }

  group('WeatherRepositoryImpl#fetchWeather(天気情報を取得する)', () {
    test('天気情報取得処理が正常なレスポンスを返却する場合_正常なレスポンスを返却する', () async {
      // arrange
      final mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
      final container = createContainer(mockWeatherRemoteDataSource);
      const returnValue = WeatherResponse(
        weatherCondition: 'sunny',
        maxTemperature: 30,
        minTemperature: 20,
        date: '2020-04-01T12:00:00+09:00',
      );
      when(
        mockWeatherRemoteDataSource.syncFetchWeather(
          request: anyNamed('request'),
        ),
      ).thenAnswer((_) async => returnValue);

      // act
      final actual =
          await container.read(weatherRepositoryProvider).fetchWeather();

      // assert
      const expected = Weather(
        condition: WeatherCondition.sunny,
        maxTemperature: 30,
        minTemperature: 20,
      );
      expect(actual, expected);
    });

    test(
      '天気情報取得処理が不正なパラメータ例外を投げる場合_アプリ内独自の不正なパラメータ例外を投げる',
      () async {
        // arrange
        final mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
        final container = createContainer(mockWeatherRemoteDataSource);
        when(
          mockWeatherRemoteDataSource.syncFetchWeather(
            request: anyNamed('request'),
          ),
        ).thenThrow(
          YumemiWeatherError.invalidParameter,
        );

        // act/assert
        await expectLater(
          container.read(weatherRepositoryProvider).fetchWeather(),
          throwsA(
            isA<InvalidParameterException>(),
          ),
        );
      },
    );

    test('天気情報取得処理が不明な天気情報例外を投げる場合_アプリ内独自の不明な天気情報例外を投げる', () async {
      // arrange
      final mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
      final container = createContainer(mockWeatherRemoteDataSource);
      when(
        mockWeatherRemoteDataSource.syncFetchWeather(
          request: anyNamed('request'),
        ),
      ).thenThrow(
        YumemiWeatherError.unknown,
      );

      // act/assert
      await expectLater(
        container.read(weatherRepositoryProvider).fetchWeather(),
        throwsA(
          isA<UnknownWeatherException>(),
        ),
      );
    });

    test('天気情報取得処理が天気状態フィールドを欠損したレスポンスを返却する場合_ドメインクラスへのデコードに失敗し、不明な天気情報例外を投げる',
        () async {
      // arrange
      final mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
      final container = createContainer(mockWeatherRemoteDataSource);
      const returnValueWithoutWeatherConditionField = WeatherResponse(
        maxTemperature: 30,
        minTemperature: 20,
        date: '2020-04-01T12:00:00+09:00',
      );
      when(
        mockWeatherRemoteDataSource.syncFetchWeather(
          request: anyNamed('request'),
        ),
      ).thenAnswer((_) async => returnValueWithoutWeatherConditionField);

      // act/assert
      await expectLater(
        container.read(weatherRepositoryProvider).fetchWeather(),
        throwsA(
          isA<UndefinedWeatherException>(),
        ),
      );
    });

    test('天気情報取得処理が最高気温フィールドを欠損したレスポンスを返却する場合_ドメインクラスへのデコードに失敗し、不明な天気情報例外を投げる',
        () async {
      // arrange
      final mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
      final container = createContainer(mockWeatherRemoteDataSource);
      const returnValueWithoutMaxTemperatureField = WeatherResponse(
        weatherCondition: 'sunny',
        minTemperature: 20,
        date: '2020-04-01T12:00:00+09:00',
      );
      when(
        mockWeatherRemoteDataSource.syncFetchWeather(
          request: anyNamed('request'),
        ),
      ).thenAnswer((_) async => returnValueWithoutMaxTemperatureField);

      // act/assert
      await expectLater(
        container.read(weatherRepositoryProvider).fetchWeather(),
        throwsA(
          isA<UndefinedWeatherException>(),
        ),
      );
    });

    test('天気情報取得処理が最低気温フィールドを欠損したレスポンスを返却する場合_ドメインクラスへのデコードに失敗し、不明な天気情報例外を投げる',
        () async {
      // arrange
      final mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
      final container = createContainer(mockWeatherRemoteDataSource);
      const returnValueWithoutMinTemperatureField = WeatherResponse(
        weatherCondition: 'sunny',
        maxTemperature: 30,
        date: '2020-04-01T12:00:00+09:00',
      );

      when(
        mockWeatherRemoteDataSource.syncFetchWeather(
          request: anyNamed('request'),
        ),
      ).thenAnswer((_) async => returnValueWithoutMinTemperatureField);

      // act/assert
      await expectLater(
        container.read(weatherRepositoryProvider).fetchWeather(),
        throwsA(
          isA<UndefinedWeatherException>(),
        ),
      );
    });

    test('天気情報取得処理が定義されていない天気状況を含むレスポンスを返却する場合_ドメインクラスへのデコードに失敗し、不明な天気情報例外を投げる',
        () async {
      // arrange
      final mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
      final container = createContainer(mockWeatherRemoteDataSource);
      const returnValueWithUndefinedWeatherCondition = WeatherResponse(
        weatherCondition: 'stormy',
        maxTemperature: 30,
        minTemperature: 20,
        date: '2020-04-01T12:00:00+09:00',
      );

      when(
        mockWeatherRemoteDataSource.syncFetchWeather(
          request: anyNamed('request'),
        ),
      ).thenAnswer((_) async => returnValueWithUndefinedWeatherCondition);

      // act/assert
      await expectLater(
        container.read(weatherRepositoryProvider).fetchWeather(),
        throwsA(
          isA<UndefinedWeatherException>(),
        ),
      );
    });
  });
}
