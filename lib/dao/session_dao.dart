import 'package:artistic_swimming_app/model/user.dart';

import 'base_dao.dart';

class SessionDao extends BaseDao {
  static const userTableName = 'session';

  static String getCreateTableScript() {
    return '''
      CREATE TABLE $userTableName(
      ${SessionEntity.fieldName} TEXT PRIMARY KEY NOT NULL
      );
      ''';
  }

  Future<SessionEntity> select() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(userTableName, limit: 1);
    return SessionEntity.fromMap(maps[0]);
  }

  Future<void> insertOne(SessionEntity entity) async {
    deleteAll();
    final db = await getDatabase();
    await db.insert(userTableName, entity.toMap());
  }

  Future<void> deleteAll() async {
    final db = await getDatabase();
    await db.delete(userTableName);
  }
}
