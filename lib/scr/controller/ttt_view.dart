import 'package:flutter/widgets.dart';

import '../../ttt_kernel.dart';
import '../base/mixin/logger_mixin.dart';
import '../stream/watcher.dart';
import 'ttt_controller.dart';

abstract class TttView<T extends TttController> extends StatelessWidget
    with LoggerMixin {
  const TttView({super.key});

  T get bloc => AppStore.find();

  Widget watch(Widget Function() builder) {
    return Watcher(builder);
  }
}
