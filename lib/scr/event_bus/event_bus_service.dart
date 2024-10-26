library ttt_event_bus;

import 'dart:async';

import '../base/app_store.dart';

part 'bloc.dart';
part 'event_streaming_mixin.dart';
part 'ttt_event.dart';

class EventBusService extends TttService with EventStreamingMixin {
  static final EventBusService instance = EventBusService._();

  EventBusService._();
  @override
  InitPriority get initPriority => InitPriority.ON_START_UP;
}
