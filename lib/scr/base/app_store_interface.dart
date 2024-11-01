part of 'ttt_base.dart';

enum ActiveProfile {
  dev,
  test,
  staging,
  production,
}

mixin AppStoreInterface on EnvironmentMixin, LoggerMixin {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> forceAppRebuild();

  BuildContext get globalContext => navigatorKey.currentContext!;

  Future get initialize;

  bool get initialized;

  GoRouter get router;

  double get width => MediaQuery.sizeOf(globalContext).width;

  double get height => MediaQuery.sizeOf(globalContext).height;

  double get ratioPixel => MediaQuery.of(globalContext).devicePixelRatio;
}
