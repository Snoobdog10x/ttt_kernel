part of '../ttt_base.dart';

abstract class TttService with LoggerMixin, Disposable {
  Completer _completer = Completer();

  Future get initialize => _completer.future;

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
          "Service is not initialized, please call ${runtimeType.toString()}.initService()");
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
