import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

@visibleForTesting
const simpleErrorDialogKey = Key('simpleErrorDialogKey');
@visibleForTesting
const simpleErrorDialogMessageKey = Key('simpleErrorDialogMessageKey');
@visibleForTesting
const simpleErrorDialogOkButtonKey = Key('simpleErrorDialogOkButtonKey');

class SimpleErrorDialog extends StatelessWidget {
  const SimpleErrorDialog({
    required String message,
    super.key,
  }) : _message = message;

  final String _message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      key: simpleErrorDialogKey,
      title: const Text('エラー'),
      content: Text(
        _message,
        key: simpleErrorDialogMessageKey,
      ),
      actions: [
        TextButton(
          key: simpleErrorDialogOkButtonKey,
          onPressed: () {
            context.pop();
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
