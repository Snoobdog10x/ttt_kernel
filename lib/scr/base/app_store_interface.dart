part of 'ttt_base.dart';

enum ActiveProfile {
  dev,
  test,
  staging,
  production,
}

mixin AppStoreInterface on EnvironmentMixin, LoggerMixin {
  GlobalKey<NavigatorState> get navigatorKey;

  Future<void> forceAppRebuild();

  BuildContext get globalContext => navigatorKey.currentContext!;

  Future get initialize;

  bool get initialized;

  GoRouter get router;

  double get width;

  double get height;

  double get ratioPixel;
}
