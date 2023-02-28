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

enum ControllerType {
  stc,
  dtc,
}

class EventEntity {
  static const fieldEvent = 'eventType';
  static const fieldTimestamp = 'timestamp';
  static const fieldControllerType = 'controllerType';

  final EventType type;
  final int timestamp;
  final ControllerType controllerType;

  const EventEntity({required this.type, required this.timestamp, required this.controllerType});

  EventEntity.fromMap(Map<String, dynamic> map)
      : type = EventType.values.firstWhere((it) => it.name == map[fieldEvent] as String),
        timestamp = map[fieldTimestamp] as int,
        controllerType = (map[fieldControllerType] as String) == ControllerType.stc.name ? ControllerType.stc : ControllerType.dtc;

  Map<String, dynamic> toMap() => {
        fieldTimestamp: timestamp,
        fieldEvent: type.name,
        fieldControllerType: controllerType.name,
      };

  int compress(int diff) {
    final paddedIndex = type.index.toString().padLeft(2, '0');
    return int.parse("$paddedIndex$diff");
  }
}
