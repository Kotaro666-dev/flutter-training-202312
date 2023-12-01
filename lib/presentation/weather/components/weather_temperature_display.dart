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
