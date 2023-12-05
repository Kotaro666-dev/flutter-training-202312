import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({
    required VoidCallback onCloseButtonPressed,
    required VoidCallback onReloadButtonPressed,
    super.key,
  })  : _onCloseButtonPressed = onCloseButtonPressed,
        _onReloadButtonPressed = onReloadButtonPressed;

  final VoidCallback _onCloseButtonPressed;
  final VoidCallback _onReloadButtonPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          child: TextButton(
            onPressed: _onCloseButtonPressed,
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
