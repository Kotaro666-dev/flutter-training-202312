import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/core/components/simple_error_dialog.dart';
import 'package:flutter_training/presentation/weather/components/action_buttons.dart';
import 'package:flutter_training/presentation/weather/components/weather_temperature_display.dart';
import 'package:flutter_training/presentation/weather/providers/weather_page_state_provider.dart';
import 'package:flutter_training/presentation/weather/weather_ui_state.dart';
import 'package:go_router/go_router.dart';

class WeatherPage extends ConsumerWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  const _Body();

  Future<void> _showErrorDialog({
    required BuildContext context,
    required String message,
  }) async {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(weatherPageStateProvider);
    final weather = state.weatherOrNull;
    final isLoading = state.isLoading;

    ref.listen<WeatherUiState>(
      weatherPageStateProvider,
      (_, next) {
        next.maybeWhen(
          error: (message) {
            unawaited(
              _showErrorDialog(
                context: context,
                message: message,
              ),
            );
          },
          orElse: () {
            // 何もしない
          },
        );
      },
    );
    return Stack(
      children: [
        Center(
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
                  weather: weather,
                ),

                // Bottom
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 80,
                      ),
                      ActionButtons(
                        onCloseButtonPressed: () {
                          context.pop();
                        },
                        onReloadButtonPressed: () {
                          unawaited(
                            ref
                                .read(weatherPageStateProvider.notifier)
                                .fetchWeather(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isLoading)
          const ColoredBox(
            // Note: showDialog で表示される背景色と同じ色を指定する
            color: Colors.black54,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
