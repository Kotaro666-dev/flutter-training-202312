import 'package:flutter/material.dart';
import 'package:flutter_training/core/exceptions/weather_exceptions.dart';
import 'package:flutter_training/data/datasources/remote/weather_remote_data_source.dart';
import 'package:flutter_training/data/repositories/weather_repository_impl.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/result.dart';
import 'package:flutter_training/domain/usecases/get_weather_use_case.dart';
import 'package:flutter_training/presentation/weather/components/action_buttons.dart';
import 'package:flutter_training/presentation/weather/components/weather_temperature_display.dart';
import 'package:go_router/go_router.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body();

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  // TODO: Session8 #9 状態管理を見直す Riverpod 導入時に移行する
  final _getWeatherUseCase = GetWeatherUseCase(
    weatherRepository: WeatherRepositoryImpl(
      weatherRemoteDataSource: WeatherRemoteDataSourceImpl(
        yumemiWeather: YumemiWeather(),
      ),
    ),
  );
  // TODO: 他のレスポンスデータも返却される際に UiState で管理するようにする
  Weather? _weather;

  void _onCloseButtonPressed() {
    context.pop();
  }

  Future<void> _onReloadButtonPressed() async {
    final newWeather = await _fetchWeather();

    setState(() {
      _weather = newWeather;
    });
  }

  Future<Weather?> _fetchWeather() async {
    // TODO: Session8 #9 状態管理を見直す Riverpod 導入時に移行する
    final result = await _getWeatherUseCase.call();
    switch (result) {
      case Success<Weather>():
        return result.data;
      case Failure<Weather>():
        _handleError(e: result.exception);
        return null;
    }
  }

  void _handleError({required Exception e}) {
    if (e is WeatherException) {
      switch (e) {
        case InvalidParameterException():
        // TODO: Handle this case.
        case UnknownWeatherException():
        // TODO: Handle this case.
        case NetworkException():
        // TODO: Handle this case.
        case UnexpectedException():
        // TODO: Handle this case.
        case UndefinedWeatherException():
        // TODO: Handle this case.
      }
    } else {
      // 汎用的なエラーハンドリング
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.5,
        // Note: 画面を三分割して考えて、Middleの部分が中央に配置されるようにする
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top
            const Spacer(),

            // Middle（本ウィジェットが画面の中央に位置する）
            WeatherTemperatureDisplay(
              weather: _weather,
              minTemperature: 10,
              maxTemperature: 20,
            ),

            // Bottom
            Expanded(
              child: Column(
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  ActionButtons(
                    onCloseButtonPressed: _onCloseButtonPressed,
                    onReloadButtonPressed: _onReloadButtonPressed,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
