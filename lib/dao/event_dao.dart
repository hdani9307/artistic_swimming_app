import 'package:artistic_swimming_app/model/event.dart';
import 'package:sqflite/sqflite.dart';

import 'base_dao.dart';

class EventDao extends BaseDao {
  static const _eventTableName = 'event';

  static String getCreateTableScript() {
    return '''
      CREATE TABLE $_eventTableName(
      ${EventEntity.fieldTimestamp} INTEGER PRIMARY KEY NOT NULL,
      ${EventEntity.fieldEvent} TEXT  NOT NULL,
      ${EventEntity.fieldControllerType} TEXT  NOT NULL
      );
      ''';
  }

  Future<List<EventEntity>> selectAllSortByTimestamp() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(_eventTableName, orderBy: EventEntity.fieldTimestamp);
    return List.generate(maps.length, (i) => EventEntity.fromMap(maps[i]));
  }

  Future<List<EventEntity>> selectAllByControllerTypeSortByTimestamp(ControllerType controllerType) async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      _eventTableName,
      where: '${EventEntity.fieldControllerType}=?',
      whereArgs: [controllerType.name],
      orderBy: EventEntity.fieldTimestamp,
    );
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
    var list = await db.rawQuery("SELECT COUNT(*) FROM $_eventTableName WHERE ${EventEntity.fieldEvent} = 'start'");
    return Sqflite.firstIntValue(list)!;
  }
}
