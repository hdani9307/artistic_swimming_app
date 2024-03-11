import 'package:artistic_swimming_app/repository/export_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dao/event_dao.dart';
import 'model/dtc_result_summary.dart';

class DtcDashboardPage extends StatefulWidget {
  const DtcDashboardPage({super.key});

  String get title => "DTC Dashboard";

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

  Future<void> _showDelete() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Megerősítés szükséges'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Minden adatot törölni fogsz ezzel'),
                Text('Biztos vagy benne?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Megerősítés'),
              onPressed: () {
                Provider.of<EventDao>(context, listen: false).deleteAll();
                Navigator.of(context).pop();
                setState(() {
                  _summary.clear();
                });
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
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Törlés',
            onPressed: () {
              _showDelete();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _summary.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              children: [
                ListTile(
                  title: Text("${_summary[index].sessionName} - Kűr #${index + 1}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                Text("Víz alatti idő: ${(_summary[index].timeUnderWater / 1000000).toStringAsPrecision(2)} s"),
                const Divider(),
                Text("Víz feletti idő: ${(_summary[index].timeAboveWater / 1000000).toStringAsPrecision(2)} s"),
                const Divider(),
                Text("Víz alatti megosztás: ${_summary[index].underWaterRatio.toStringAsPrecision(2)} %"),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
