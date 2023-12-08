import 'package:flutter/material.dart';
import 'package:flutter_training/core/gen/assets.gen.dart';
import 'package:flutter_training/domain/models/weather.dart';

class WeatherImage extends StatelessWidget {
  const WeatherImage({
    required WeatherCondition? condition,
    super.key,
  }) : _condition = condition;

  final WeatherCondition? _condition;

  @override
  Widget build(BuildContext context) {
    if (_condition == null) {
      return const Placeholder();
    } else {
      return _condition.svgGenImage.svg();
    }
  }
}

extension _WeatherSvgGenImage on WeatherCondition {
  SvgGenImage get svgGenImage => switch (this) {
        WeatherCondition.sunny => Assets.weather.sunny,
        WeatherCondition.cloudy => Assets.weather.cloudy,
        WeatherCondition.rainy => Assets.weather.rainy,
      };
}
