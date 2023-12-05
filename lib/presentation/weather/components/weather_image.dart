import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      return _weather.svgPicture;
    }
  }
}

extension _WeatherAssetName on Weather {
  SvgPicture get svgPicture => switch (this) {
        Weather.sunny => Assets.weather.sunny.svg(),
        Weather.cloudy => Assets.weather.cloudy.svg(),
        Weather.rainy => Assets.weather.rainy.svg(),
      };
}
