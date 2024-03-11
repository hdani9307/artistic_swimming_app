import 'dart:async';

import 'package:artistic_swimming_app/dao/session_dao.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dao/event_dao.dart';
import 'dtc_dashboard.dart';
import 'model/event.dart';

class DtcPage extends StatefulWidget {
  const DtcPage({super.key});

  String get title => "DTC";

  @override
  State<DtcPage> createState() => DtcPageState();
}

class DtcPageState extends State<DtcPage> {
  final Stopwatch _stopwatch = Stopwatch();

  bool _started = false;
  bool _underWater = false;
  String _timerText = "00:00";
  String _sessionName = "";

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), _timerCallback);
    _getSessionName();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  Future<void> _getSessionName() async {
    var session = await Provider.of<SessionDao>(context, listen: false).select();
    setState(() {
      _sessionName = session.name;
    });
  }

  _timerCallback(Timer timer) {
    var seconds = _stopwatch.elapsed.inSeconds;
    var minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    var secs = (seconds % 60).toString().padLeft(2, '0');
    setState(() {
      _timerText = "$minutes:$secs";
    });
  }

  _setUnderWater(bool value) {
    setState(() {
      _underWater = value;
      if (_underWater) {
        _saveEvent(EventType.underWater);
      } else {
        _saveEvent(EventType.aboveWater);
      }
    });
  }

  _toggleStarted() {
    _saveEvent(_started ? EventType.stop : EventType.start);
    setState(() {
      _started = !_started;
      if (_started) {
        _stopwatch.reset();
        _stopwatch.start();
      } else {
        _stopwatch.stop();
        _setUnderWater(false);
      }
    });
  }

  _saveEvent(EventType eventType) {
    Provider.of<EventDao>(context, listen: false).insert(
      EventEntity(type: eventType, timestamp: DateTime.now().microsecondsSinceEpoch, sessionName: _sessionName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.title} - $_sessionName"),
        actions: [
          IconButton(
            icon: _started ? const Icon(Icons.stop) : const Icon(Icons.play_arrow),
            tooltip: _started ? 'Stop' : 'Start',
            onPressed: () {
              _toggleStarted();
            },
          ),
          IconButton(
            icon: const Icon(Icons.dashboard),
            tooltip: 'Dashboard',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DtcDashboardPage()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
                  child: Text(
                    style: const TextStyle(fontSize: 50),
                    textAlign: TextAlign.center,
                    _timerText,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Center(
                  child: SwitchListTile(
                    title: const Text(textAlign: TextAlign.center, 'Víz alatt'),
                    value: _underWater,
                    onChanged: _started
                        ? (bool value) {
                            _setUnderWater(value);
                          }
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
