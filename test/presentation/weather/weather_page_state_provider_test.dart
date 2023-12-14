import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/core/exceptions/error_message.dart';
import 'package:flutter_training/core/exceptions/weather_exceptions.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:flutter_training/domain/providers/weather_provider.dart';
import 'package:flutter_training/domain/repositories/weather_repository.dart';
import 'package:flutter_training/domain/usecases/get_weather_use_case.dart';
import 'package:flutter_training/presentation/weather/providers/weather_page_state_provider.dart';
import 'package:flutter_training/presentation/weather/weather_ui_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

@GenerateNiceMocks([MockSpec<WeatherRepository>()])
import 'weather_page_state_provider_test.mocks.dart';

void main() {
  late MockWeatherRepository mockWeatherRepository;
  late ProviderContainer container;

  setUp(
    () => {
      mockWeatherRepository = MockWeatherRepository(),
      container = ProviderContainer(
        overrides: [
          getWeatherUseCaseProvider.overrideWithValue(
            GetWeatherUseCase(
              weatherRepository: mockWeatherRepository,
            ),
          ),
        ],
      ),
    },
  );

  group('WeatherPageState(天気画面の状態)', () {
    test(
      '天気画面の状態が生成された場合_天気画面の状態を初期状態にする',
      () {
        // act
        final actual = container.read(weatherPageStateProvider);

        // assert
        const expected = WeatherUiState.initial();
        expect(actual, expected);
      },
    );

    test('天気情報取得に成功した場合_天気画面の状態を成功状態にする', () async {
      // arrange
      when(mockWeatherRepository.fetchWeather()).thenAnswer(
        (_) async => const Weather(
          condition: WeatherCondition.sunny,
          maxTemperature: 30,
          minTemperature: 20,
        ),
      );

      // act
      await container.read(weatherPageStateProvider.notifier).fetchWeather();
      final actual = container.read(weatherPageStateProvider);

      // assert
      const expected = WeatherUiState.success(
        weather: Weather(
          condition: WeatherCondition.sunny,
          maxTemperature: 30,
          minTemperature: 20,
        ),
      );
      expect(actual, expected);
    });

    test('天気情報取得に失敗した場合_天気画面の状態を失敗状態にする', () async {
      // arrange
      when(mockWeatherRepository.fetchWeather())
          .thenThrow(UndefinedWeatherException(message: 'テスト用例外'));

      // act
      await container.read(weatherPageStateProvider.notifier).fetchWeather();
      final actual = container.read(weatherPageStateProvider);

      // assert
      final errorMessage =
          getErrorMessage(e: UndefinedWeatherException(message: 'テスト用例外'));
      final expected = WeatherUiState.error(
        message: errorMessage,
      );
      expect(actual, expected);
    });
  });
}
