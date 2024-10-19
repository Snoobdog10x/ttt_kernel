import 'package:flutter/widgets.dart';

import 'watcher.dart';

class TttStream<T> extends ValueNotifier<T> {
  TttStream(super.value);

  @override
  T get value {
    var currentWatcher = Watcher.currentWatcherState;
    var currentValue = super.value;
    if (currentWatcher == null) {
      return currentValue;
    }

    currentWatcher.subscribeStream(this);
    return currentValue;
  }
}
