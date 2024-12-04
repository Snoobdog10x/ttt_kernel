library ttt_stream;

import 'dart:async';
import 'dart:collection';

import 'package:flutter/widgets.dart';

import '../base/ttt_base.dart';
import '../event_bus/event_bus_service.dart';

part 'ttt_bool.dart';
part 'ttt_list.dart';
part 'ttt_map.dart';
part 'ttt_num.dart';
part 'ttt_set.dart';
part 'ttt_string.dart';
part 'watcher.dart';

typedef StreamOnValue<T> = void Function(T value);

class TttStream<T> with LoggerMixin, Disposable, EventStreamingMixin<T> {
  T _value;

  TttStream(this._value);

  set value(T value) {
    emit(value);
    _value = value;
  }

  void notifyListeners() {
    emit(_value);
  }

  T get value {
    var currentProxy = Watcher._currentWatcherState;
    if (currentProxy == null) {
      return _value;
    }

    currentProxy.subscribeStream<T>(this);
    return _value;
  }

  void close() {
    onDispose();
  }

  @protected
  @override
  void onInit() {}

  @protected
  @override
  void onDispose() {
    closeStream();
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
