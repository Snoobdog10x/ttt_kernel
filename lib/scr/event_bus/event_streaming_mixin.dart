part of 'event_bus_service.dart';

mixin EventStreamingMixin<T> on Disposable {
  Stream<T> get _stream => _streamController.stream;
  final StreamController<T> _streamController = StreamController.broadcast();

  Stream<E> on<E extends T>({String? tag}) {
    return _stream.where((event) {
      if (event is! E) {
        return false;
      }

      if (T == TttEvent && (event as TttEvent).tag != tag) {
        return false;
      }

      return true;
    }).cast<E>();
  }

  StreamSubscription<E> subscribe<E extends T>(
    void Function(E) onData, {
    String? tag,
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return on<E>(tag: tag).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  void closeStream() {
    _streamController.close();
  }

  void emit<E extends T>(E event) {
    _streamController.add(event);
  }
}
