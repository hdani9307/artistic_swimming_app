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
      : type = EventType.values.firstWhere((it) => it.name == map[fieldEvent] as String),
        timestamp = map[fieldTimestamp] as int;

  Map<String, dynamic> toMap() => {
        fieldTimestamp: timestamp,
        fieldEvent: type.name,
      };

  int compress(int diff) {
    final paddedIndex = type.index.toString().padLeft(2, '0');
    return int.parse("$paddedIndex$diff");
  }
}

class EventExportData {
  final int min;
  final List<int> diffs;

  const EventExportData({
    required this.min,
    required this.diffs,
  });

  Map<String, dynamic> toMap() => {"m": min, "d": diffs};
}
