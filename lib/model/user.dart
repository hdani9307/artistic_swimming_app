class UserEntity {
  static var fieldName = 'name';

  final String name;

  const UserEntity({required this.name});

  UserEntity.fromMap(Map<String, dynamic> map) : name = map[fieldName] as String;

  Map<String, dynamic> toMap() => {fieldName: name};
}
