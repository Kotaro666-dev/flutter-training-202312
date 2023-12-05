import 'package:flutter/material.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/presentation/weather/components/weather_image.dart';

class WeatherTemperatureDisplay extends StatelessWidget {
  const WeatherTemperatureDisplay({
    required Weather? weather,
    required int minTemperature,
    required int maxTemperature,
    super.key,
  })  : _weather = weather,
        _minTemperature = minTemperature,
        _maxTemperature = maxTemperature;

  final Weather? _weather;
  final int _minTemperature;
  final int _maxTemperature;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: WeatherImage(
            weather: _weather,
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
    required int temperature,
    required Color fontColor,
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
