import 'dart:collection';

import 'ttt_stream.dart';

class TttMap<K, V> extends TttStream<Map<K, V>> with MapMixin<K, V> {
  TttMap(super.value);

  factory TttMap.from(Map<K, V> other) {
    return TttMap(Map.from(other));
  }

  /// Creates a [LinkedHashMap] with the same keys and values as [other].
  factory TttMap.of(Map<K, V> other) {
    return TttMap(Map.of(other));
  }

  ///Creates an unmodifiable hash based map containing the entries of [other].
  factory TttMap.unmodifiable(Map<dynamic, dynamic> other) {
    return TttMap(Map.unmodifiable(other));
  }

  /// Creates an identity map with the default implementation, [LinkedHashMap].
  factory TttMap.identity() {
    return TttMap(Map.identity());
  }

  @override
  V? operator [](Object? key) {
    return value[key as K];
  }

  @override
  void operator []=(K key, V value) {
    this.value[key] = value;
    notifyListeners();
  }

  @override
  void clear() {
    value.clear();
    notifyListeners();
  }

  @override
  Iterable<K> get keys => value.keys;

  @override
  V? remove(Object? key) {
    final val = value.remove(key);
    notifyListeners();
    return val;
  }
}
