import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/core/components/simple_error_dialog.dart';
import 'package:flutter_training/core/exceptions/error_message.dart';
import 'package:flutter_training/data/datasources/remote/weather_remote_data_source.dart';
import 'package:flutter_training/data/repositories/weather_repository_impl.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/domain/result.dart';
import 'package:flutter_training/domain/usecases/get_weather_use_case.dart';
import 'package:flutter_training/presentation/weather/components/action_buttons.dart';
import 'package:flutter_training/presentation/weather/components/weather_temperature_display.dart';
import 'package:flutter_training/presentation/weather/weather_ui_state.dart';
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

  WeatherUiState _uiState = WeatherUiState.initial;

  void _onCloseButtonPressed() {
    context.pop();
  }

  Future<void> _onReloadButtonPressed() async {
    await _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    // TODO: Session8 #9 状態管理を見直す Riverpod 導入時に移行する
    final result = await _getWeatherUseCase.call();
    switch (result) {
      case Success<Weather>():
        setState(() {
          _uiState = _uiState.copyWith(
            minTemperature: result.data.minTemperature.toString(),
            maxTemperature: result.data.maxTemperature.toString(),
            condition: result.data.condition,
          );
        });
      case Failure<Weather>():
        setState(() {
          _uiState = _uiState.copyWith(
            minTemperature: '**',
            maxTemperature: '**',
            condition: null,
          );
        });
        _handleError(e: result.exception);
    }
  }

  void _handleError({required Exception e}) {
    debugPrint(e.toString());
    unawaited(_showErrorDialog(e: e));
  }

  Future<void> _showErrorDialog({required Exception e}) async {
    final message = getErrorMessage(e: e);
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return SimpleErrorDialog(
          message: message,
        );
      },
    );
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
              condition: _uiState.condition,
              minTemperature: _uiState.minTemperature,
              maxTemperature: _uiState.maxTemperature,
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
