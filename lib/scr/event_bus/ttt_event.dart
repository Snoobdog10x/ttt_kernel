part of 'event_bus_service.dart';

abstract class TttEvent {
  final String? tag;

  const TttEvent({this.tag});
}
