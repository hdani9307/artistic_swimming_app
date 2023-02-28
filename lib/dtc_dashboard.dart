import 'package:artistic_swimming_app/repository/export_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dao/event_dao.dart';
import 'model/dtc_result_summary.dart';

class DtcDashboardPage extends StatefulWidget {
  const DtcDashboardPage({super.key});

  @override
  State<DtcDashboardPage> createState() => DtcDashboardPageState();
}

class DtcDashboardPageState extends State<DtcDashboardPage> {
  List<DTCResultSummary> _summary = [];

  @override
  void initState() {
    super.initState();
    _getDtcData();
  }

  Future<void> _getDtcData() async {
    var summary = await Provider.of<ExportRepository>(context, listen: false).getDTCResultSummary();
    setState(() {
      _summary = summary;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Difficulty Technical Controller Dashboard')),
      body: ListView.builder(
        itemCount: _summary.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  style: const TextStyle(fontSize: 20),
                  "Routine $index",
                ),
                ListView.builder(
                  itemCount: _summary[index].hybrids.length,
                  itemBuilder: (hybridContext, hybridIndex) {
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Text(
                            style: const TextStyle(fontSize: 20),
                            "Hybrid $hybridIndex",
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
