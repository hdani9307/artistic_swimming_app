import 'package:artistic_swimming_app/dao/event_dao.dart';
import 'package:artistic_swimming_app/dao/session_dao.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDao {
  static const _databaseName = 'artistic_swimming.db';

  @protected
  Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) async {
        final batch = db.batch();
        batch.execute(EventDao.getCreateTableScript());
        batch.execute(SessionDao.getCreateTableScript());
        await batch.commit();
      },
      version: 1,
    );
  }
}
