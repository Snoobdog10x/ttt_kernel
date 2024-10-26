part of 'app_store.dart';

InitPriority _initState = InitPriority.ON_START_UP;

extension AppServiceInitializerExtension on AppStoreInterface {
  InitPriority get initState => _initState;

  Future<void> _onInitServices(InitPriority filter) async {
    if (_initState.index != filter.index) {
      logInfo("already $filter!!!");
      return;
    }

    logInfo("On $filter");
    var filterServices =
        services.where((service) => service.initPriority == filter).toList();
    filterServices.sort((a, b) => a.order.compareTo(b.order));
    for (var service in filterServices) {
      await service.initService();
    }
    _initState = InitPriority.values[filter.index + 1];
  }

  Future<void> startUp() => _onInitServices(InitPriority.ON_START_UP);

  Future<void> onSplash() => _onInitServices(InitPriority.ON_SPLASH);

  void afterSplash() => _onInitServices(InitPriority.AFTER_SPLASH);
}
