import 'package:flutter/material.dart';
import 'package:flutter_training/core/gen/assets.gen.dart';
import 'package:flutter_training/domain/models/weather.dart';

class WeatherImage extends StatelessWidget {
  const WeatherImage({
    required Weather? weather,
    super.key,
  }) : _weather = weather;

  final Weather? _weather;

  @override
  Widget build(BuildContext context) {
    if (_weather == null) {
      return const Placeholder();
    } else {
      return _weather.svgGenImage.svg();
    }
  }
}

extension _WeatherSvgGenImage on Weather {
  SvgGenImage get svgGenImage => switch (this) {
        Weather.sunny => Assets.weather.sunny,
        Weather.cloudy => Assets.weather.cloudy,
        Weather.rainy => Assets.weather.rainy,
      };
}
