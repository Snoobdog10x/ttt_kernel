library ttt_stream;

import 'dart:collection';

import 'package:flutter/widgets.dart';

part 'ttt_list.dart';
part 'ttt_map.dart';
part 'ttt_set.dart';
part 'watcher.dart';

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
