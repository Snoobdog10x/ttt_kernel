part of 'event_bus_service.dart';

mixin EventStreamingMixin {
  Stream<TttEvent> get _stream => _streamController.stream;
  final StreamController<TttEvent> _streamController =
      StreamController.broadcast();

  Stream<E> on<E extends TttEvent>({String? tag}) {
    if (E is! TttEvent) {
      return _stream.where((event) {
        if (event is! E) {
          return false;
        }

        if (event.tag != tag) {
          return false;
        }

        return true;
      }).cast<E>();
    }

    return _stream as Stream<E>;
  }

  StreamSubscription<E> subscribe<E extends TttEvent>(
    void Function(E) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return on<E>().listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  void closeStream() {
    _streamController.close();
  }

  void emit<E extends TttEvent>(E event) {
    _streamController.add(event);
  }
}
