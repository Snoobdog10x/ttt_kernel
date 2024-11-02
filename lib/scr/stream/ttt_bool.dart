part of 'ttt_stream.dart';

class TttBool extends TttStream<bool> {
  TttBool(super.initial);

  @override
  String toString() {
    return value ? "true" : "false";
  }
}

class TttNullableBool extends TttStream<bool?> {
  TttNullableBool([super.initial]);

  @override
  String toString() {
    return "$value";
  }
}

extension TttBoolExt on TttStream<bool> {
  bool get isTrue => value;

  bool get isFalse => !isTrue;

  bool operator &(bool other) => other && value;

  bool operator |(bool other) => other || value;

  bool operator ^(bool other) => !other == value;

  /// Toggles the bool [value] between false and true.
  /// A shortcut for `flag.value = !flag.value;`
  void toggle() {
    value = !value;
    // return this;
  }
}

extension TttNullableBoolExt on TttStream<bool?> {
  bool? get isTrue => value;

  bool? get isFalse {
    if (value != null) return !isTrue!;
    return null;
  }

  bool? operator &(bool other) {
    if (value != null) {
      return other && value!;
    }
    return null;
  }

  bool? operator |(bool other) {
    if (value != null) {
      return other || value!;
    }
    return null;
  }

  bool? operator ^(bool other) => !other == value;

  /// Toggles the bool [value] between false and true.
  /// A shortcut for `flag.value = !flag.value;`
  void toggle() {
    if (value != null) {
      value = !value!;
    }
  }
}
