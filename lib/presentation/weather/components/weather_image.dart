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
      return SvgPicture.asset(
        _weather.assetName,
      );
    }
  }
}

extension _WeatherAssetName on Weather {
  String get assetName => switch (this) {
        Weather.sunny => Assets.weather.sunny,
        Weather.cloudy => Assets.weather.cloudy,
        Weather.rainy => Assets.weather.rainy,
      };
}
