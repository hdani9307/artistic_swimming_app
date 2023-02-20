import 'dart:math';

import 'package:artistic_swimming_app/model/event.dart';
import 'package:sqflite/sqflite.dart';

import 'base_dao.dart';

class EventDao extends BaseDao {
  Future<List<EventEntity>> selectAll() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query(BaseDao.eventTableName);
    return List.generate(maps.length, (i) => EventEntity.fromMap(maps[i]));
  }

  Future<void> insert(EventEntity entity) async {
    final db = await getDatabase();
    await db.insert(BaseDao.eventTableName, entity.toMap());
  }

  Future<void> deleteAll() async {
    final db = await getDatabase();
    await db.delete(BaseDao.eventTableName);
  }

  Future<int> countRounds() async {
    final db = await getDatabase();
    var list = await db.rawQuery("SELECT COUNT(*) FROM ${BaseDao.eventTableName}");
    return Sqflite.firstIntValue(list)!;
  }
}
