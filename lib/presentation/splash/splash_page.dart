import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/core/components/after_layout_mixin.dart';
import 'package:flutter_training/core/router/go_router_config.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AfterLayoutMixin {
  @override
  Future<void> onAfterLayout() async {
    await _goToWeatherPageAfterFiveMilliseconds();
  }

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.green,
      ),
    );
  }

  Future<void> _goToWeatherPageAfterFiveMilliseconds() async {
    // 画面の描写が完了した後に、0.5秒待つ
    await Future<void>.delayed(
      const Duration(milliseconds: 500),
    );

    // When a BuildContext is used,
    // its mounted property must be checked after an asynchronous gap.
    if (!mounted) {
      return;
    }

    // 天気画面に遷移して戻ってくることを待つ
    await const WeatherPageRoute().push<void>(context);

    // 天気画面に遷移して、戻ってきたら再度天気画面に遷移する
    unawaited(doActionAfterFrameCompletes());
  }
}
