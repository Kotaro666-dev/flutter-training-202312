import 'package:flutter/material.dart';

class WeatherTemperatureDisplay extends StatelessWidget {
  const WeatherTemperatureDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Placeholder(),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                '** ℃',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Text(
                '** ℃',
                textAlign: TextAlign.center,
              ),
            ),
          ],
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
