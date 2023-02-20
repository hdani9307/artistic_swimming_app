import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dao/event_dao.dart';
import 'model/event.dart';

class DtcPage extends StatefulWidget {
  const DtcPage({super.key});

  String get title => "Difficulty Technical Controller";

  String formatTime(int time) {
    if (time <= 9) {
      return "0$time";
    } else {
      return time.toString();
    }
  }

  @override
  State<DtcPage> createState() => DtcPageState();
}

class DtcPageState extends State<DtcPage> {
  final Stopwatch _stopwatch = Stopwatch();

  bool _started = false;
  int _movements = 0;
  bool _underWater = false;
  String _timerText = "00:00";

  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), _timerCallback);
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  _timerCallback(Timer timer) {
    var seconds = _stopwatch.elapsed.inSeconds;
    var minutes = widget.formatTime(seconds ~/ 60);
    var secs = widget.formatTime(seconds % 60);
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
        _resetMovement();
      }
    });
  }

  _increaseMovement() {
    setState(() {
      _movements++;
    });
  }

  _resetMovement() {
    setState(() {
      _movements = 0;
    });
  }

  _toggleStarted() {
    _saveEvent(_started ? EventType.start : EventType.stop);
    setState(() {
      _started = !_started;
      if (_started) {
        _stopwatch.reset();
        _stopwatch.start();
      } else {
        _stopwatch.stop();
        _resetMovement();
        _setUnderWater(false);
      }
    });
  }

  _saveEvent(EventType eventType) {
    Provider.of<EventDao>(context, listen: false).insert(
      EventEntity(
        type: eventType,
        timestamp: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const font = TextStyle(fontSize: 20);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: _started ? const Icon(Icons.stop) : const Icon(Icons.play_arrow),
            tooltip: _started ? 'Stop' : 'Start',
            onPressed: () {
              _toggleStarted();
            },
          ),
          IconButton(
            icon: const Icon(Icons.qr_code),
            tooltip: 'Export',
            onPressed: () {
              // handle the press
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
                      title: const Text(textAlign: TextAlign.center, 'Under water'),
                      value: _underWater,
                      onChanged: _started
                          ? (bool value) {
                              _setUnderWater(value);
                            }
                          : null,
                    ),
                  )),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(textStyle: font, backgroundColor: Colors.green),
                  onPressed: _underWater
                      ? () {
                          _increaseMovement();
                          _saveEvent(EventType.leg);
                        }
                      : null,
                  child: Text(textAlign: TextAlign.center, 'Number of movements: $_movements'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
