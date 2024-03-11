enum EventType {
  start,
  majorMistake,
  obviousMistake,
  smallMistake,
  stop,
  underWater,
  aboveWater,
}

class EventEntity {
  static const fieldId = 'id';
  static const fieldEvent = 'eventType';
  static const fieldTimestamp = 'timestamp';
  static const fieldSessionName = 'sessionName';

  final EventType type;
  final int timestamp;
  final String sessionName;

  const EventEntity({required this.type, required this.timestamp, required this.sessionName});

  EventEntity.fromMap(Map<String, dynamic> map)
      : type = EventType.values.firstWhere((it) => it.name == map[fieldEvent] as String),
        timestamp = map[fieldTimestamp] as int,
        sessionName = map[fieldSessionName] as String;

  Map<String, dynamic> toMap() => {
        fieldTimestamp: timestamp,
        fieldEvent: type.name,
        fieldSessionName: sessionName,
      };
}
