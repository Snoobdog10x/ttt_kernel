part of '../app_store.dart';

mixin Disposable on LoggerMixin {
  FutureOr<void> onInit();

  FutureOr<void> onDispose();
}
