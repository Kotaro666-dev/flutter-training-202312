// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_router_config.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashPageRoute,
    ];

RouteBase get $splashPageRoute => GoRouteData.$route(
      path: '/',
      factory: $SplashPageRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: 'weather',
          factory: $WeatherPageRouteExtension._fromState,
        ),
      ],
    );

extension $SplashPageRouteExtension on SplashPageRoute {
  static SplashPageRoute _fromState(GoRouterState state) =>
      const SplashPageRoute();

  String get location => GoRouteData.$location(
        '/',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $WeatherPageRouteExtension on WeatherPageRoute {
  static WeatherPageRoute _fromState(GoRouterState state) =>
      const WeatherPageRoute();

  String get location => GoRouteData.$location(
        '/weather',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
