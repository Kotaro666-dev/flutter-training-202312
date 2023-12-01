import 'package:flutter/material.dart';

class WeatherTemperatureDisplay extends StatelessWidget {
  const WeatherTemperatureDisplay({
    required int minTemperature,
    required int maxTemperature,
    super.key,
  })  : _maxTemperature = maxTemperature,
        _minTemperature = minTemperature;

  final int _minTemperature;
  final int _maxTemperature;

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
                  temperature: _minTemperature,
                  fontColor: Colors.blue,
                ),
              ),
              Expanded(
                child: TemperatureLabel(
                  temperature: _maxTemperature,
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
    required int temperature,
    required Color fontColor,
    super.key,
  })  : _fontColor = fontColor,
        _temperature = temperature;

  final int _temperature;
  final Color _fontColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.labelLarge?.copyWith(
          color: _fontColor,
        ) ??
        TextStyle(color: _fontColor);
    return Text(
      '$_temperature ℃',
      textAlign: TextAlign.center,
      style: textStyle,
    );
  }
}
