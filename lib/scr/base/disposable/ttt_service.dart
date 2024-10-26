part of '../app_store.dart';

enum InitPriority {
  ON_START_UP,
  ON_SPLASH,
  AFTER_SPLASH,
  LAZY,
}

abstract class TttService with LoggerMixin, Disposable {
  InitPriority get initPriority;

  int get order => 0;

  late Completer _completer;

  Future get initialize => _completer.future;

  TttService() {
    _completer = Completer();
    AppStore.services.add(this);

    if (initPriority == InitPriority.LAZY) {
      initService();
    }
  }

  Future<void> initService() async {
    if (_completer.isCompleted) {
      logWarning("Service already initialized");
      return;
    }

    logInfo("init");
    await onInit();
    _completer.complete();
  }

  Future<void> disposeService() async {
    if (!_completer.isCompleted) {
      logWarning(
          "Service is not initialized, please call ${runtimeType}.initService()");
      return;
    }

    logInfo("dispose");
    _completer = Completer();
    await onDispose();
  }

  @protected
  @override
  Future<void> onInit() async {}

  @protected
  @override
  Future<void> onDispose() async {}
}
