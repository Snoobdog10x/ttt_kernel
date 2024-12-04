library ttt_event_bus;

import 'dart:async';

import '../base/ttt_base.dart';

part 'bloc.dart';
part 'event_streaming_mixin.dart';
part 'ttt_event.dart';

class EventBusService extends TttService with EventStreamingMixin {
  static final EventBusService instance = EventBusService._();

  EventBusService._();

  @override
  Future<void> onDispose() async {
    closeStream();
  }

  @override
  Future<void> onInit() async {}
}
