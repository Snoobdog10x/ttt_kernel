import 'dart:async';

import '../mixin/logger_mixin.dart';

mixin Disposable on LoggerMixin {
  FutureOr<void> onInit();

  FutureOr<void> onDispose();
}
