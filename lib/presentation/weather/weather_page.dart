import 'package:flutter/material.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: FractionallySizedBox(
        widthFactor: 0.5,
        // Note: 画面を三分割して考えて、Middleの部分が中央に配置されるようにする
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top
            Spacer(),

            // Middle（本ウィジェットが画面の中央に位置する）
            WeatherAndTemperatures(),

            // Bottom
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  ActionButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherAndTemperatures extends StatelessWidget {
  const WeatherAndTemperatures({super.key});

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

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          child: TextButton(
            onPressed: () {},
            child: const Text('Close'),
          ),
        ),
        Flexible(
          child: TextButton(
            onPressed: () {},
            child: const Text('Reload'),
          ),
        ),
      ],
    );
  }
}
