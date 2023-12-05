import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/presentation/weather/weather_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    unawaited(_goToWeatherPageAfterFrameCompletes());
    super.initState();
  }

  Future<void> _goToWeatherPageAfterFrameCompletes() async {
    // 画面の描写が完了することを待つ
    await WidgetsBinding.instance.endOfFrame;
    // 画面の描写が完了した後に、0.5秒待つ
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    // When a BuildContext is used,
    // its mounted property must be checked after an asynchronous gap.
    if (!context.mounted) {
      return;
    }

    // 天気画面に遷移して戻ってくることを待つ
    await Navigator.of(context).pushNamed(WeatherPage.routeName);

    // 天気画面に遷移して、戻ってきたら再度天気画面に遷移する
    unawaited(_goToWeatherPageAfterFrameCompletes());
  }

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.green,
      ),
    );
  }
}
