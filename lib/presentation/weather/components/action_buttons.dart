import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: TextButton(
            onPressed: () {
              // TODO: ボタン押下時に何かする
            },
            child: const Text('Close'),
          ),
        ),
        Flexible(
          child: TextButton(
            onPressed: () {
              // TODO: ボタン押下時に何かする
            },
            child: const Text('Reload'),
          ),
        ),
      ],
    );
  }
}
