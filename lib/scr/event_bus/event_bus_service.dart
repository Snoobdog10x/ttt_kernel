import '../base/disposable/ttt_service.dart';
import 'event_streaming_mixin.dart';

class EventBusService extends TttService with EventStreamingMixin {
  static final EventBusService instance = EventBusService._();

  EventBusService._();
  @override
  InitPriority get initPriority => InitPriority.ON_START_UP;
}
