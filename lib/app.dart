import 'package:flutter/material.dart';
import 'package:flutter_training/core/router/go_router_config.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouterConfig,
    );
  }
}
