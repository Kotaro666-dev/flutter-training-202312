import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SimpleErrorDialog extends StatelessWidget {
  const SimpleErrorDialog({
    required String message,
    super.key,
  }) : _message = message;

  final String _message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      title: const Text('エラー'),
      content: Text(_message),
      actions: [
        TextButton(
          onPressed: () {
            context.pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
