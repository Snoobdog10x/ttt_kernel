library ttt_stream;

import 'dart:collection';

import 'package:flutter/widgets.dart';

part 'ttt_bool.dart';
part 'ttt_list.dart';
part 'ttt_map.dart';
part 'ttt_num.dart';
part 'ttt_set.dart';
part 'ttt_string.dart';
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

extension ListExtension<T> on List<T> {
  TttList<T> get stream => TttList(this);
}

extension MapExtension<K, V> on Map<K, V> {
  TttMap<K, V> get stream => TttMap(this);
}

extension TttSetExtension<T> on Set<T> {
  TttSet<T> get stream => TttSet(this);
}

extension IntExtension on int {
  TttStream<int> get stream => TttStream(this);
}

extension DoubleExtension on double {
  TttStream<double> get stream => TttStream(this);
}

extension BoolExtension on bool {
  TttStream<bool> get stream => TttStream(this);
}
