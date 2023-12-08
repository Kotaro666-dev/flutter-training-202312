import 'package:flutter/material.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/presentation/weather/components/weather_image.dart';

class WeatherTemperatureDisplay extends StatelessWidget {
  const WeatherTemperatureDisplay({
    required WeatherCondition? condition,
    required String minTemperature,
    required String maxTemperature,
    super.key,
  })  : _condition = condition,
        _minTemperature = minTemperature,
        _maxTemperature = maxTemperature;

  final WeatherCondition? _condition;
  final String _minTemperature;
  final String _maxTemperature;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: WeatherImage(
            condition: _condition,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _TemperatureLabel(
                temperature: _minTemperature,
                fontColor: Colors.blue,
              ),
            ),
            Expanded(
              child: _TemperatureLabel(
                temperature: _maxTemperature,
                fontColor: Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _TemperatureLabel extends StatelessWidget {
  const _TemperatureLabel({
    required String temperature,
    required Color fontColor,
  })  : _fontColor = fontColor,
        _temperature = temperature;

  final String _temperature;
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
