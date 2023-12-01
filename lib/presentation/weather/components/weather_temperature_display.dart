import 'package:flutter/material.dart';

class WeatherTemperatureDisplay extends StatelessWidget {
  const WeatherTemperatureDisplay({
    required this.minTemperature,
    required this.maxTemperature,
    super.key,
  });

  final int minTemperature;
  final int maxTemperature;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AspectRatio(
          aspectRatio: 1,
          // TODO: 天気画像を表示する
          child: Placeholder(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: TemperatureLabel(
                  temperature: minTemperature,
                  fontColor: Colors.blue,
                ),
              ),
              Expanded(
                child: TemperatureLabel(
                  temperature: maxTemperature,
                  fontColor: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TemperatureLabel extends StatelessWidget {
  const TemperatureLabel({
    required this.temperature,
    required this.fontColor,
    super.key,
  });

  final int temperature;
  final Color fontColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.labelLarge?.copyWith(
          color: fontColor,
        ) ??
        TextStyle(color: fontColor);
    return Text(
      '$temperature ℃',
      textAlign: TextAlign.center,
      style: textStyle,
    );
  }
}
