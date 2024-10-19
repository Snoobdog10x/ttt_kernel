import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../event_bus/bloc.dart';
import '../app_store.dart';
import '../mixin/logger_mixin.dart';
import 'disposable.dart';

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
  @mustCallSuper
  @override
  Future<void> onInit() async {
    if (this is Bloc) {
      (this as Bloc).listenEvents();
    }
  }

  @protected
  @mustCallSuper
  @override
  Future<void> onDispose() async {
    if (this is Bloc) {
      (this as Bloc).disposeSubscriptions();
    }
  }
}
