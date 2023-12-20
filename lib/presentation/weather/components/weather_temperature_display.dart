import 'package:flutter/material.dart';
import 'package:flutter_training/domain/models/weather.dart';
import 'package:flutter_training/presentation/weather/components/weather_image.dart';

@visibleForTesting
const minTemperatureLabelTextKey = Key('minTemperatureLabelTextKey');
@visibleForTesting
const maxTemperatureLabelTextKey = Key('maxTemperatureLabelTextKey');

class WeatherTemperatureDisplay extends StatelessWidget {
  const WeatherTemperatureDisplay({
    required Weather? weather,
    super.key,
  }) : _weather = weather;

  final Weather? _weather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: WeatherImage(
            condition: _weather?.condition,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _TemperatureLabel(
                labelTextKey: minTemperatureLabelTextKey,
                temperature: _weather?.minTemperature,
                fontColor: Colors.blue,
              ),
            ),
            Expanded(
              child: _TemperatureLabel(
                labelTextKey: maxTemperatureLabelTextKey,
                temperature: _weather?.maxTemperature,
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
    required Key labelTextKey,
    required int? temperature,
    required Color fontColor,
  })  : _labelTextKey = labelTextKey,
        _fontColor = fontColor,
        _temperature = temperature;

  final Key _labelTextKey;
  final int? _temperature;
  final Color _fontColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.labelLarge?.copyWith(
          color: _fontColor,
        ) ??
        TextStyle(color: _fontColor);
    final temperatureText = _temperature != null ? '$_temperature ℃' : '** ℃';
    return Text(
      temperatureText,
      key: _labelTextKey,
      textAlign: TextAlign.center,
      style: textStyle,
    );
  }
}
