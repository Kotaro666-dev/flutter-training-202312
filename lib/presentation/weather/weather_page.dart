import 'package:flutter/material.dart';
import 'package:flutter_training/presentation/weather/components/action_buttons.dart';
import 'package:flutter_training/presentation/weather/components/weather_temperature_display.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

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
            const WeatherTemperatureDisplay(
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
                    onReloadButtonPressed: () {
                      // TOOD: ボタン押下時に天気予報を取得する処理を実行する
                    },
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
