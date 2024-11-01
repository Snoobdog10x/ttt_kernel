part of '../ttt_base.dart';

mixin Disposable on LoggerMixin {
  FutureOr<void> onInit();

  FutureOr<void> onDispose();
}
