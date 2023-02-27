import 'package:artistic_swimming_app/model/event.dart';
import 'package:sqflite/sqflite.dart';

import 'base_dao.dart';

class EventDao extends BaseDao {
  static const _eventTableName = 'event';

  static String getCreateTableScript() {
    return '''
      CREATE TABLE $_eventTableName(
      ${EventEntity.fieldTimestamp} INTEGER PRIMARY KEY NOT NULL,
      ${EventEntity.fieldEvent} TEXT  NOT NULL
      );
      ''';
  }

  Future<List<EventEntity>> selectAll() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_eventTableName);
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

  Future<int> countRounds() async {
    final db = await getDatabase();
    var list = await db.rawQuery("SELECT COUNT(*) FROM ${_eventTableName}");
    return Sqflite.firstIntValue(list)!;
  }
}
