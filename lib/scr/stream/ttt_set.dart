import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'ttt_stream.dart';

class TttSet<E> extends TttStream<Set<E>> with SetMixin<E> {
  TttSet(super.value);

  /// Special override to push() element(s) in a reactive way
  /// inside the List,
  TttSet<E> operator +(Set<E> val) {
    addAll(val);
    notifyListeners();
    return this;
  }

  void update(void Function(Iterable<E>? value) fn) {
    fn(value);
    notifyListeners();
  }

  @override
  @protected
  set value(Set<E> val) {
    if (value == val) return;
    value = val;
    notifyListeners();
  }

  @override
  bool add(E value) {
    final val = this.value.add(value);
    notifyListeners();
    return val;
  }

  @override
  bool contains(Object? element) {
    return value.contains(element);
  }

  @override
  Iterator<E> get iterator => value.iterator;

  @override
  int get length => value.length;

  @override
  E? lookup(Object? element) {
    return value.lookup(element);
  }

  @override
  bool remove(Object? value) {
    var hasRemoved = this.value.remove(value);
    if (hasRemoved) {
      notifyListeners();
    }
    return hasRemoved;
  }

  @override
  Set<E> toSet() {
    return value.toSet();
  }

  @override
  void addAll(Iterable<E> elements) {
    value.addAll(elements);
    notifyListeners();
  }

  @override
  void clear() {
    value.clear();
    notifyListeners();
  }

  @override
  void removeAll(Iterable<Object?> elements) {
    value.removeAll(elements);
    notifyListeners();
  }

  @override
  void retainAll(Iterable<Object?> elements) {
    value.retainAll(elements);
    notifyListeners();
  }

  @override
  void retainWhere(bool Function(E) test) {
    value.retainWhere(test);
    notifyListeners();
  }
}
