import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg_test/flutter_svg_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/app.dart';
import 'package:flutter_training/core/components/simple_error_dialog.dart';
import 'package:flutter_training/core/exceptions/error_message.dart';
import 'package:flutter_training/core/exceptions/weather_exceptions.dart';
import 'package:flutter_training/core/gen/assets.gen.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/models/weather_condition.dart';
import 'package:flutter_training/domain/providers/weather_provider.dart';
import 'package:flutter_training/domain/repositories/weather_repository.dart';
import 'package:flutter_training/domain/usecases/get_weather_use_case.dart';
import 'package:flutter_training/presentation/splash/splash_page.dart';
import 'package:flutter_training/presentation/weather/components/action_buttons.dart';
import 'package:flutter_training/presentation/weather/components/weather_image.dart';
import 'package:flutter_training/presentation/weather/components/weather_temperature_display.dart';
import 'package:flutter_training/presentation/weather/weather_page.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<WeatherRepository>()])
import 'weather_page_widget_test.mocks.dart';

void main() {
  // 例外 "A RenderFlex overflowed by XXX pixels on some part."への対応
  Future<void> initializeDeviceSurfaceSize() async {
    final binding = TestWidgetsFlutterBinding.ensureInitialized();
    await binding.setSurfaceSize(const Size(1080, 1920));
  }

  testWidgets('天気画面が初回表示された場合_プレースホルダー画像とデフォルトの気温が表示される', (widgetTester) async {
    // arrange
    await initializeDeviceSurfaceSize();
    await widgetTester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: WeatherPage(),
        ),
      ),
    );

    // assert
    final minTemperatureFinder = find.byKey(minTemperatureLabelKey);
    final minTemperatureText =
        minTemperatureFinder.evaluate().single.widget as Text;
    final maxTemperatureFinder = find.byKey(maxTemperatureLabelKey);
    final maxTemperatureText =
        maxTemperatureFinder.evaluate().single.widget as Text;
    expect(find.byKey(placeholderImageKey), findsOneWidget);
    expect(minTemperatureText.data, '** ℃');
    expect(maxTemperatureText.data, '** ℃');
  });

  testWidgets('天気状況が晴れの場合_晴れの画像が表示される', (widgetTester) async {
    // arrange
    final mockWeatherRepository = MockWeatherRepository();
    await initializeDeviceSurfaceSize();
    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: [
          getWeatherUseCaseProvider.overrideWithValue(
            GetWeatherUseCase(
              weatherRepository: mockWeatherRepository,
            ),
          ),
        ],
        child: const MaterialApp(
          home: WeatherPage(),
        ),
      ),
    );
    when(mockWeatherRepository.fetchWeather()).thenAnswer(
      (_) async => const Weather(
        condition: WeatherCondition.sunny,
        maxTemperature: 30,
        minTemperature: 20,
      ),
    );

    // act
    await widgetTester.tap(find.byKey(reloadButtonKey));
    await widgetTester.pump();

    // assert
    final asset = Assets.weather.sunny.svg();
    expect(find.svg(asset.bytesLoader), findsOneWidget);
  });

  testWidgets('天気状況が曇りの場合_曇りの画像が表示される', (widgetTester) async {
    // arrange
    final mockWeatherRepository = MockWeatherRepository();
    await initializeDeviceSurfaceSize();
    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: [
          getWeatherUseCaseProvider.overrideWithValue(
            GetWeatherUseCase(
              weatherRepository: mockWeatherRepository,
            ),
          ),
        ],
        child: const MaterialApp(
          home: WeatherPage(),
        ),
      ),
    );
    when(mockWeatherRepository.fetchWeather()).thenAnswer(
      (_) async => const Weather(
        condition: WeatherCondition.cloudy,
        maxTemperature: 30,
        minTemperature: 20,
      ),
    );

    // act
    await widgetTester.tap(find.byKey(reloadButtonKey));
    await widgetTester.pump();

    // assert
    final asset = Assets.weather.cloudy.svg();
    expect(find.svg(asset.bytesLoader), findsOneWidget);
  });

  testWidgets('天気状況が雨の場合_雨の画像が表示される', (widgetTester) async {
    // arrange
    final mockWeatherRepository = MockWeatherRepository();
    await initializeDeviceSurfaceSize();
    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: [
          getWeatherUseCaseProvider.overrideWithValue(
            GetWeatherUseCase(
              weatherRepository: mockWeatherRepository,
            ),
          ),
        ],
        child: const MaterialApp(
          home: WeatherPage(),
        ),
      ),
    );
    when(mockWeatherRepository.fetchWeather()).thenAnswer(
      (_) async => const Weather(
        condition: WeatherCondition.rainy,
        maxTemperature: 30,
        minTemperature: 20,
      ),
    );

    // act
    await widgetTester.tap(find.byKey(reloadButtonKey));
    await widgetTester.pump();

    // assert
    final asset = Assets.weather.rainy.svg();
    expect(find.svg(asset.bytesLoader), findsOneWidget);
  });

  testWidgets('天気状況の最高気温が30の場合_最高気温が30度と表示される', (widgetTester) async {
    // arrange
    final mockWeatherRepository = MockWeatherRepository();
    await initializeDeviceSurfaceSize();
    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: [
          getWeatherUseCaseProvider.overrideWithValue(
            GetWeatherUseCase(
              weatherRepository: mockWeatherRepository,
            ),
          ),
        ],
        child: const MaterialApp(
          home: WeatherPage(),
        ),
      ),
    );
    when(mockWeatherRepository.fetchWeather()).thenAnswer(
      (_) async => const Weather(
        condition: WeatherCondition.sunny,
        maxTemperature: 30,
        minTemperature: 20,
      ),
    );

    // act
    await widgetTester.tap(find.byKey(reloadButtonKey));
    await widgetTester.pump();

    // assert
    final finder = find.byKey(maxTemperatureLabelKey);
    final text = finder.evaluate().single.widget as Text;
    expect(text.data, '30 ℃');
  });

  testWidgets('天気状況の最低気温が10の場合_最低気温が10度と表示される', (widgetTester) async {
    // arrange
    final mockWeatherRepository = MockWeatherRepository();
    await initializeDeviceSurfaceSize();
    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: [
          getWeatherUseCaseProvider.overrideWithValue(
            GetWeatherUseCase(
              weatherRepository: mockWeatherRepository,
            ),
          ),
        ],
        child: const MaterialApp(
          home: WeatherPage(),
        ),
      ),
    );
    when(mockWeatherRepository.fetchWeather()).thenAnswer(
      (_) async => const Weather(
        condition: WeatherCondition.sunny,
        maxTemperature: 30,
        minTemperature: 10,
      ),
    );

    // act
    await widgetTester.tap(find.byKey(reloadButtonKey));
    await widgetTester.pump();

    // assert
    final finder = find.byKey(minTemperatureLabelKey);
    final text = finder.evaluate().single.widget as Text;
    expect(text.data, '10 ℃');
  });

  testWidgets('天気取得に失敗した場合_エラーダイアログが表示される', (widgetTester) async {
    // arrange
    final mockWeatherRepository = MockWeatherRepository();
    await initializeDeviceSurfaceSize();
    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: [
          getWeatherUseCaseProvider.overrideWithValue(
            GetWeatherUseCase(
              weatherRepository: mockWeatherRepository,
            ),
          ),
        ],
        child: const MaterialApp(
          home: WeatherPage(),
        ),
      ),
    );
    when(mockWeatherRepository.fetchWeather())
        .thenThrow(UndefinedWeatherException(message: 'テスト用例外'));

    // act
    await widgetTester.tap(find.byKey(reloadButtonKey));
    await widgetTester.pump();

    // assert
    final errorDialogMessageFinder = find.byKey(simpleErrorDialogMessageKey);
    final errorDialogMessageText =
        errorDialogMessageFinder.evaluate().single.widget as Text;
    final errorMessage =
        getErrorMessage(e: UndefinedWeatherException(message: 'テスト用例外'));
    expect(find.byKey(simpleErrorDialogKey), findsOneWidget);
    expect(errorDialogMessageText.data, errorMessage);
  });

  testWidgets('【成功ケース】天気画面のcloseボタンを押下した場合_スプラッシュ画面が表示される',
      (widgetTester) async {
    // arrange
    await initializeDeviceSurfaceSize();
    await widgetTester.runAsync(() async {
      // arrange
      await widgetTester.pumpWidget(
        const ProviderScope(
          child: App(),
        ),
      );

      // act/assert
      // Note: スプラッシュ画面が表示されていることを確認する
      expect(find.byType(SplashPage), findsOneWidget);
      expect(find.byType(WeatherPage), findsNothing);

      // Note: スプラッシュ画面から天気画面に遷移する遅延処理のタイマー（0.5秒間）を待つ
      await Future<void>.delayed(const Duration(milliseconds: 500));
      await widgetTester.pumpAndSettle();

      // Note: 天気画面が表示されていることを確認する
      expect(find.byType(SplashPage), findsNothing);
      expect(find.byType(WeatherPage), findsOneWidget);

      await widgetTester.tap(find.byKey(closeButtonKey));
      await widgetTester.pumpAndSettle();

      // Note: スプラッシュ画面が表示されていることを確認する
      expect(find.byType(SplashPage), findsOneWidget);
      expect(find.byType(WeatherPage), findsNothing);
    });
  });

  testWidgets('【失敗ケース】天気画面のcloseボタンを押下した場合_スプラッシュ画面が表示される',
      (widgetTester) async {
    // arrange
    await initializeDeviceSurfaceSize();
    await widgetTester.pumpWidget(
      const ProviderScope(
        child: App(),
      ),
    );

    // act/assert
    // Note: スプラッシュ画面が表示されていることを確認する
    expect(find.byType(SplashPage), findsOneWidget);
    expect(find.byType(WeatherPage), findsNothing);

    // Note: スプラッシュ画面から天気画面に遷移する遅延処理のタイマー（0.5秒間）を待つ
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));
    expect(find.byType(SplashPage), findsNothing);
    expect(find.byType(WeatherPage), findsOneWidget);

    await widgetTester.tap(find.byKey(closeButtonKey));
    await widgetTester.pumpAndSettle();

    // Note: スプラッシュ画面が表示されていることを確認する
    expect(
      find.byType(SplashPage),
      findsOneWidget,
    ); // ここでエラーになる（Found 0 widgets with type "SplashPage"）
    expect(find.byType(WeatherPage), findsNothing);

    // Note: A Timer is still pending even after the widget tree was disposed. への対応
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));
  });
}
