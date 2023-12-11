import 'dart:async';

import 'package:flutter/material.dart';

mixin AfterLayoutMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    unawaited(doActioinAfterFrameCompletes());
    super.initState();
  }

  Future<void> doActionAfterFrameCompletes() async {
    // 画面の描写が完了することを待つ
    await WidgetsBinding.instance.endOfFrame;

    // 画面の描写が完了した後に、onAfterLayoutを呼び出す
    await onAfterLayout();
  }

  /// 画面の描写が完了した後に呼び出される
  Future<void> onAfterLayout();
}
