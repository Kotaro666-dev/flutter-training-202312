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
    return const Center(
      child: FractionallySizedBox(
        widthFactor: 0.5,
        // Note: 画面を三分割して考えて、Middleの部分が中央に配置されるようにする
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top
            Spacer(),

            // Middle（本ウィジェットが画面の中央に位置する）
            WeatherTemperatureDisplay(),

            // Bottom
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  ActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
