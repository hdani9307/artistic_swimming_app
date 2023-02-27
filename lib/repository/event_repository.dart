import 'dart:math';

import 'package:artistic_swimming_app/dao/event_dao.dart';
import 'package:artistic_swimming_app/dao/user_dao.dart';

import '../model/export.dart';

class ExportRepository {
  static const _step = 300;
  final EventDao eventDao;
  final UserDao userDao;

  ExportRepository({
    required this.eventDao,
    required this.userDao,
  });

  void exportEvents(void Function(ExportMeta meta, List<ExportData> data) onSuccess) async {
    final user = await userDao.select();
    final events = await eventDao.selectAllSortByTimestamp();
    final startTimestamp = events[0].timestamp;

    final compressedDiffs = <int>[];
    for (var result in events) {
      compressedDiffs.add(result.compress(result.timestamp - startTimestamp));
    }

    var i = 0;
    final exportData = <ExportData>[];

    for (var subListStart = 0; subListStart <= compressedDiffs.length; subListStart += _step) {
      final end = min(subListStart + _step, compressedDiffs.length - 1);
      final subList = compressedDiffs.sublist(subListStart, end);
      exportData.add(ExportData(index: i++, diffs: subList));
    }

    final meta = ExportMeta(
      numberOfFragments: i,
      min: startTimestamp,
      name: user.name,
    );

    onSuccess(meta, exportData);
  }
}
