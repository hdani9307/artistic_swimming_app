enum EventType {
  start,
  majorMistake,
  obviousMistake,
  smallMistake,
  stop,
  leg,
  underWater,
  aboveWater,
}

class EventEntity {
  static var fieldEvent = 'eventType';
  static var fieldTimestamp = 'timestamp';

  final EventType type;
  final int timestamp;

  const EventEntity({
    required this.type,
    required this.timestamp,
  });

  EventEntity.fromMap(Map<String, dynamic> map)
      : type = EventType.values.firstWhere((it) => it.toString() == map[fieldEvent] as String),
        timestamp = map[fieldTimestamp] as int;

  Map<String, dynamic> toMap() => {
        fieldEvent: type.name,
        fieldTimestamp: timestamp,
      };
}
