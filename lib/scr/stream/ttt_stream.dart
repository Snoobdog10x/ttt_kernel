library ttt_stream;

import 'dart:async';
import 'dart:collection';

import 'package:flutter/widgets.dart';

import '../base/ttt_base.dart';

part 'ttt_bool.dart';
part 'ttt_list.dart';
part 'ttt_map.dart';
part 'ttt_num.dart';
part 'ttt_set.dart';
part 'ttt_string.dart';
part 'watcher.dart';

typedef StreamOnValue<T> = void Function(T value);

class TttStreamSubscription<T> {
  bool canceled = false;
  late final TttStream<T> _stream;
  final StreamOnValue<T> _onValue;

  TttStreamSubscription(this._stream, this._onValue);

  void _listener() {
    _onValue(_stream.value);
  }

  void _listen() {
    _stream.addListener(_listen);
  }

  void cancel() {
    if (canceled) {
      return;
    }

    canceled = true;
    _stream.removeListener(_listener);
  }
}

class TttStream<T> extends ValueNotifier<T> with LoggerMixin {
  final Completer _completer = Completer();

  TttStream(super.value);

  Future<void> onValue(StreamOnValue<T> onValue) async {
    void listener() => onValue(value);
    addListener(listener);
    await _completer.future;
    removeListener(listener);
  }

  TttStreamSubscription<T> listen(StreamOnValue<T> onValue) {
    var subscription = TttStreamSubscription(this, onValue);
    subscription._listen();
    return subscription;
  }

  @override
  void dispose() {
    if (_completer.isCompleted) {
      logError("Stream has been closed please init new one");
      return;
    }

    _completer.complete();
    super.dispose();
  }

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
