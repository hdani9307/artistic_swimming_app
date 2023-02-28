import 'dart:math';

import 'package:artistic_swimming_app/dao/event_dao.dart';
import 'package:artistic_swimming_app/dao/user_dao.dart';
import 'package:artistic_swimming_app/model/event.dart';

import '../model/dtc_result_summary.dart';
import '../model/export.dart';

class ExportRepository {
  static const _step = 300;
  final EventDao eventDao;
  final UserDao userDao;

  ExportRepository({
    required this.eventDao,
    required this.userDao,
  });

  Future<List<DTCResultSummary>> getDTCResultSummary() async {
    final events = await eventDao.selectAllByControllerTypeSortByTimestamp(ControllerType.dtc);
    final summaryList = <DTCResultSummary>[];

    var summary = DTCResultSummary();
    var hybrid = Hybrid();
    var lastUnderWater = 0;

    for (var event in events) {
      if (event.type == EventType.start) {
        summary = DTCResultSummary();
      } else if (event.type == EventType.stop) {
        summaryList.add(summary);
      } else if (event.type == EventType.leg) {
        hybrid.numberOfMoves++;
      } else if (event.type == EventType.underWater) {
        hybrid = Hybrid();
        lastUnderWater = event.timestamp;
      } else if (event.type == EventType.aboveWater) {
        if (lastUnderWater > 0) {
          hybrid.timeUnderWater = event.timestamp - lastUnderWater;
          summary.hybrids.add(hybrid);
        }
      } else {
        throw Exception("Unmapped ${event.type.name}");
      }
    }

    return summaryList;
  }

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
