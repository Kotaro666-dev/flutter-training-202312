import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    required VoidCallback onReloadButtonPressed,
    super.key,
  }) : _onReloadButtonPressed = onReloadButtonPressed;

  final VoidCallback _onReloadButtonPressed;

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
            onPressed: _onReloadButtonPressed,
            child: const Text('Reload'),
          ),
        ),
      ],
    );
  }
}
