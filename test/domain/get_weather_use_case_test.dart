import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/core/exceptions/weather_exceptions.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:flutter_training/domain/providers/weather_provider.dart';
import 'package:flutter_training/domain/repositories/weather_repository.dart';
import 'package:flutter_training/domain/result.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([MockSpec<WeatherRepository>()])
import 'get_weather_use_case_test.mocks.dart';

void main() {
  ProviderContainer createContainer(
    MockWeatherRepository mockWeatherRepository,
  ) {
    // Create a ProviderContainer, and optionally allow specifying parameters.
    final container = ProviderContainer(
      overrides: [
        weatherRepositoryProvider.overrideWithValue(
          mockWeatherRepository,
        ),
      ],
    );

    // When the test ends, dispose the container.
    addTearDown(container.dispose);

    return container;
  }

  group('GetWeatherUseCase#call(天気情報を取得する)', () {
    test('天気情報取得処理に成功した場合_成功結果を返却する', () async {
      // arrange
      final mockWeatherRepository = MockWeatherRepository();
      final container = createContainer(mockWeatherRepository);
      const returnValue = Weather(
        condition: WeatherCondition.sunny,
        maxTemperature: 30,
        minTemperature: 20,
      );
      when(
        mockWeatherRepository.fetchWeather(),
      ).thenAnswer((_) async => returnValue);

      // act
      final actual = await container.read(getWeatherUseCaseProvider).call();

      // assert
      const expected = Weather(
        condition: WeatherCondition.sunny,
        maxTemperature: 30,
        minTemperature: 20,
      );
      expect(actual, isA<Success<Weather>>());
      expect((actual as Success<Weather>).data, expected);
    });

    test('天気情報取得処理に失敗した場合_失敗結果を返却する', () async {
      // arrange
      final mockWeatherRepository = MockWeatherRepository();
      final container = createContainer(mockWeatherRepository);
      final exception = UndefinedWeatherException(message: 'テスト用例外');
      when(
        mockWeatherRepository.fetchWeather(),
      ).thenThrow(exception);

      // act
      final actual = await container.read(getWeatherUseCaseProvider).call();

      // assert
      expect(actual, isA<Failure<Weather>>());
    });
  });
}
