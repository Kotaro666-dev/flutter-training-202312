import 'package:flutter/material.dart';
import 'package:flutter_training/presentation/splash/splash_page.dart';
import 'package:flutter_training/presentation/weather/weather_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashPage(),
      routes: {
        WeatherPage.routeName: (_) => const WeatherPage(),
      },
    );
  }
}
