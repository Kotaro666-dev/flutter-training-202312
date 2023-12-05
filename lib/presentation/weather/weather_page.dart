import 'package:flutter/material.dart';
import 'package:flutter_training/data/datasources/remote/weather_remote_data_source.dart';
import 'package:flutter_training/data/repositories/weather_repository_impl.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/usecases/get_weather_use_case.dart';
import 'package:flutter_training/presentation/weather/components/action_buttons.dart';
import 'package:flutter_training/presentation/weather/components/weather_temperature_display.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  static const routeName = '/weather';

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

  Future<void> _onReloadButtonPressed() async {
    final newWeather = await _fetchWeather();

    setState(() {
      _weather = newWeather;
    });
  }

  Future<Weather?> _fetchWeather() {
    // TODO: Session8 #9 状態管理を見直す Riverpod 導入時に移行する
    return _getWeatherUseCase.call();
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
