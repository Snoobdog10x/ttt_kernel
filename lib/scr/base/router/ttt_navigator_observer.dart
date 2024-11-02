part of '../ttt_base.dart';

class TttNavigatorObserver extends NavigatorObserver {
  Route? _previousRoute;
  Route? _currentRoute;

  bool get isDialogShow => _currentRoute is RawDialogRoute;

  bool get isBottomSheetShow => _currentRoute is ModalBottomSheetRoute;

  bool get isPageShow => _currentRoute is PageRoute;

  String? get currentRoute => _currentRoute?.settings.name;

  String? get previousRoute => _previousRoute?.settings.name;

  @override
  void didPop(Route route, Route? previousRoute) {
    _currentRoute = previousRoute;
    _previousRoute = route;
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _previousRoute = previousRoute;
    _currentRoute = route;
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _currentRoute = previousRoute;
    _previousRoute = route;
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _previousRoute = oldRoute;
    _currentRoute = newRoute;
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }
}
