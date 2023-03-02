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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation needed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This action will delete all of your data'),
                Text('Are you sure?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Provider.of<EventDao>(context, listen: false).deleteAll();
                _summary.clear();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Difficulty Technical Controller Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Delete',
            onPressed: () {
             _showMyDialog();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _summary.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: _generateHybridViews(index),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _generateHybridViews(int index) {
    var widgets = <Widget>[];
    widgets.add(
      ListTile(
        title: Text('Routine #${index + 1}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      ),
    );
    for (var i = 0; i < _summary[index].hybrids.length; i++) {
      widgets.add(
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hybrid: #${i + 1}"),
              Text("Number of movements: ${_summary[index].hybrids[i].numberOfMoves}"),
              Text("Time under water: ${(_summary[index].hybrids[i].timeUnderWater / 1000).toStringAsPrecision(2)} s"),
              const Divider()
            ],
          ),
        ),
      );
    }

    return widgets;
  }
}
