part of 'ttt_storage.dart';

enum StorageOperator { CREATE, READ, UPDATE, DELETE }

class StorageEvent<T> extends TttEvent {
  final StorageOperator operator;
  final T value;

  StorageEvent({
    required String key,
    required this.value,
    required this.operator,
  }) : super(tag: key);
}
