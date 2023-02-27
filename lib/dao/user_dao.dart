import 'package:artistic_swimming_app/model/user.dart';

import 'base_dao.dart';

class UserDao extends BaseDao {
  static const userTableName = 'user';

  static String getCreateTableScript() {
    return '''
      CREATE TABLE $userTableName(
      ${UserEntity.fieldName} TEXT PRIMARY KEY NOT NULL
      );
      ''';
  }

  Future<UserEntity> select() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(userTableName, limit: 1);
    return UserEntity.fromMap(maps[0]);
  }

  Future<void> insertOne(UserEntity entity) async {
    deleteAll();
    final db = await getDatabase();
    await db.insert(userTableName, entity.toMap());
  }

  Future<void> deleteAll() async {
    final db = await getDatabase();
    await db.delete(userTableName);
  }
}
