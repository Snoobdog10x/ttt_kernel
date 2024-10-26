part of 'ttt_stream.dart';

class TttList<E> extends TttStream<List<E>> with ListMixin<E> {
  TttList(super.value);

  factory TttList.filled(int length, E fill, {bool growable = false}) {
    return TttList(List.filled(length, fill, growable: growable));
  }

  factory TttList.empty({bool growable = false}) {
    return TttList(List.empty(growable: growable));
  }

  factory TttList.from(Iterable elements, {bool growable = true}) {
    return TttList(List.from(elements, growable: growable));
  }

  factory TttList.of(Iterable<E> elements, {bool growable = true}) {
    return TttList(List.of(elements, growable: growable));
  }

  factory TttList.generate(int length, E Function(int index) generator,
      {bool growable = true}) {
    return TttList(List.generate(length, generator, growable: growable));
  }

  factory TttList.unmodifiable(Iterable elements) {
    return TttList(List.unmodifiable(elements));
  }

  @override
  Iterator<E> get iterator => value.iterator;

  @override
  void operator []=(int index, E val) {
    value[index] = val;
    notifyListeners();
  }

  /// Special override to push() element(s) in a reactive way
  /// inside the List,
  @override
  TttList<E> operator +(Iterable<E> val) {
    addAll(val);
    notifyListeners();

    return this;
  }

  @override
  E operator [](int index) {
    return value[index];
  }

  @override
  void add(E element) {
    value.add(element);
    notifyListeners();
  }

  @override
  void addAll(Iterable<E> iterable) {
    value.addAll(iterable);
    notifyListeners();
  }

  @override
  void removeWhere(bool Function(E element) test) {
    value.removeWhere(test);
    notifyListeners();
  }

  @override
  void retainWhere(bool Function(E element) test) {
    value.retainWhere(test);
    notifyListeners();
  }

  @override
  int get length => value.length;

  @override
  set length(int newLength) {
    value.length = newLength;
    notifyListeners();
  }

  @override
  void insertAll(int index, Iterable<E> iterable) {
    value.insertAll(index, iterable);
    notifyListeners();
  }

  @override
  Iterable<E> get reversed => value.reversed;

  @override
  Iterable<E> where(bool Function(E) test) {
    return value.where(test);
  }

  @override
  Iterable<E> whereType<E>() {
    return value.whereType<E>();
  }

  @override
  void sort([int Function(E a, E b)? compare]) {
    value.sort(compare);
    notifyListeners();
  }
}
