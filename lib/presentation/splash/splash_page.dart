import 'package:flutter/material.dart';
import 'package:flutter_training/core/components/weather_page_navigation_mixin.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with WeatherPageNavigationMixin {
  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.green,
      ),
    );
  }
}
