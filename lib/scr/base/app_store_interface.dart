part of 'app_store.dart';

enum ActiveProfile {
  dev,
  test,
  staging,
  production,
}

abstract class AppStoreInterface with EnvironmentMixin, LoggerMixin {
  final List<TttService> services = [];
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext get context => navigatorKey.currentContext!;

  double get width => MediaQuery.sizeOf(context).width;

  double get height => MediaQuery.sizeOf(context).height;

  double get ratioPixel => MediaQuery.of(context).devicePixelRatio;
}
