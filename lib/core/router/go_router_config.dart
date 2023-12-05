import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/presentation/splash/splash_page.dart';
import 'package:flutter_training/presentation/weather/weather_page.dart';
import 'package:go_router/go_router.dart';

// Note: The generated file will always have the name [source_file].g.dart.
part 'go_router_config.g.dart';

final goRouterConfig = GoRouter(
  routes: $appRoutes,
  debugLogDiagnostics: kDebugMode,
);

@TypedGoRoute<SplashPageRoute>(
  path: SplashPageRoute.path,
  routes: [
    TypedGoRoute<WeatherPageRoute>(
      path: WeatherPageRoute.path,
    ),
  ],
)
@immutable
class SplashPageRoute extends GoRouteData {
  const SplashPageRoute();

  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashPage();
  }
}

@immutable
class WeatherPageRoute extends GoRouteData {
  const WeatherPageRoute();

  static const path = 'weather';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WeatherPage();
  }
}
