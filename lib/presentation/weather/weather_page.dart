import 'package:flutter/material.dart';
import 'package:flutter_training/core/exceptions/exceptions.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/presentation/weather/components/action_buttons.dart';
import 'package:flutter_training/presentation/weather/components/weather_temperature_display.dart';
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
  final _yumemiWeather = YumemiWeather();
  Weather? _weather;

  void _onReloadButtonPressed() {
    final newWeather = _fetchYumemiWeather();

    setState(() {
      _weather = newWeather;
    });
  }

  Weather? _fetchYumemiWeather() {
    try {
      final newWeather = _yumemiWeather.fetchSimpleWeather();
      return Weather.fromName(newWeather);
    } on UnknownWeatherException catch (e) {
      debugPrint(e.toString());
      return null;
    } on Exception catch (e) {
      // TODO Session5 #6 API のエラーハンドリングを実装する
      debugPrint(e.toString());
      return null;
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
