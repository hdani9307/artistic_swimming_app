class SessionEntity {
  static var fieldName = 'name';

  final String name;

  const SessionEntity({required this.name});

  SessionEntity.fromMap(Map<String, dynamic> map) : name = map[fieldName] as String;

  Map<String, dynamic> toMap() => {fieldName: name};
}
