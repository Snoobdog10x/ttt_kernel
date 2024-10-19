import 'dart:async';

import 'event_bus_service.dart';
import 'ttt_event.dart';

mixin Bloc {
  final List<StreamSubscription<TttEvent>> _subscribedEvents = [];

  void emit<E extends TttEvent>(E event) =>
      EventBusService.instance.emit(event);

  void on<E extends TttEvent>(
    void Function(E event) onEvent,
  ) {
    if (_hasSubscribeEvent<E>()) {
      return;
    }

    var subscription = EventBusService.instance.subscribe<E>(onEvent);
    _subscribedEvents.add(subscription);
  }

  bool _hasSubscribeEvent<E extends TttEvent>() {
    return _subscribedEvents.any((element) => element is StreamSubscription<E>);
  }

  void listenEvents();

  void disposeSubscriptions() {
    for (var e in _subscribedEvents) {
      e.cancel();
    }
  }
}
