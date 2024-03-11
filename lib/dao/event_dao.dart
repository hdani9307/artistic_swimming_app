import 'package:artistic_swimming_app/model/event.dart';

import 'base_dao.dart';

class EventDao extends BaseDao {
  static const _eventTableName = 'event';

  static String getCreateTableScript() {
    return '''
      CREATE TABLE $_eventTableName(
      ${EventEntity.fieldId} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      ${EventEntity.fieldTimestamp} INTEGER NOT NULL,
      ${EventEntity.fieldEvent} TEXT  NOT NULL,
      ${EventEntity.fieldSessionName} TEXT  NOT NULL
      );
      ''';
  }

  Future<List<EventEntity>> selectAllSortByTimestamp() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_eventTableName, orderBy: EventEntity.fieldTimestamp);
    return List.generate(maps.length, (i) => EventEntity.fromMap(maps[i]));
  }

  Future<void> insert(EventEntity entity) async {
    final db = await getDatabase();
    await db.insert(_eventTableName, entity.toMap());
  }

  Future<void> deleteAll() async {
    final db = await getDatabase();
    await db.delete(_eventTableName);
  }
}
