import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/event.dart';

class BaseDao {
  static const _databaseName = 'artistic_swimming.db';

  static const eventTableName = 'event';

  @protected
  Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _databaseName),
      onCreate: (db, version) async {
        final batch = db.batch();
        _createEventTable(batch);
        await batch.commit();
      },
      version: 1,
    );
  }

  void _createEventTable(Batch batch) {
    batch.execute(
      '''
      CREATE TABLE $eventTableName(
      ${EventEntity.fieldTimestamp} INTEGER PRIMARY KEY NOT NULL,
      ${EventEntity.fieldEvent} TEXT  NOT NULL
      );
      ''',
    );
  }
}
