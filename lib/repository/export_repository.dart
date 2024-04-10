import 'dart:io';

import 'package:artistic_swimming_app/dao/event_dao.dart';
import 'package:artistic_swimming_app/model/event.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';

import '../model/dtc_result_summary.dart';

class ExportRepository {
  final EventDao eventDao;

  final List<dynamic> csvHeader = [
    "timeUnderWater",
    "timeAboveWater",
    "underWaterRatio",
    "sessionLength",
    "sessionName",
  ];

  ExportRepository({
    required this.eventDao,
  });

  Future<List<DTCResultSummary>> getDTCResultSummary() async {
    final events = await eventDao.selectAllSortByTimestamp();
    final summaryList = <DTCResultSummary>[];

    var summary = DTCResultSummary();
    var timeUnderWater = 0;
    var lastUnderWater = 0;
    var start = 0;
    var stop = 0;

    for (var event in events) {
      if (event.type == EventType.start) {
        summary = DTCResultSummary();

        timeUnderWater = 0;
        lastUnderWater = 0;
        start = 0;
        stop = 0;

        summary.sessionName = event.sessionName;

        start = event.timestamp;
      } else if (event.type == EventType.stop) {
        stop = event.timestamp;

        summary.timeUnderWater = timeUnderWater;
        summary.sessionLength = stop - start;
        summary.timeAboveWater = summary.sessionLength - summary.timeUnderWater;
        summary.underWaterRatio = summary.timeUnderWater / summary.sessionLength * 100;

        summaryList.add(summary);
      } else if (event.type == EventType.underWater) {
        lastUnderWater = event.timestamp;
      } else if (event.type == EventType.aboveWater) {
        if (lastUnderWater > 0) {
          timeUnderWater += event.timestamp - lastUnderWater;
        }
      } else {
        throw Exception("Unmapped ${event.type.name}");
      }
    }

    return summaryList;
  }

  Future<File> exportDTCResultSummary() async {
    var summary = await getDTCResultSummary();
    var exportData = summary.map((e) => e.toDynamic()).toList();

    var csv = const ListToCsvConverter().convert([csvHeader] + exportData);
    final file = await _localFile;
    return file.writeAsString(csv);
  }

  Future<String> get _localPath async {
    final directory = await getDownloadsDirectory();

    return directory!.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/dtc_export.txt');
  }
}
