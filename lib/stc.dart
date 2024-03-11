import 'package:artistic_swimming_app/model/event.dart';
import 'package:flutter/material.dart';


class StcPage extends StatefulWidget {
  const StcPage({super.key});

  String get title => "Synchronization Technical Controller";

  @override
  State<StcPage> createState() => StcPageState();
}

class StcPageState extends State<StcPage> {
  bool _started = false;
  int _small = 0;
  int _major = 0;
  int _obvious = 0;

  _toggleStarted() {
    _saveEvent(_started ? EventType.start : EventType.stop);
    setState(() {
      _started = !_started;
      if (_started) {
        _small = 0;
        _major = 0;
        _obvious = 0;
      }
    });
  }

  _saveEvent(EventType eventType) {
    if (eventType == EventType.majorMistake) {
      setState(() {
        _major++;
      });
    } else if (eventType == EventType.obviousMistake) {
      setState(() {
        _obvious++;
      });
    } else if (eventType == EventType.smallMistake) {
      setState(() {
        _small++;
      });
    }
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(textStyle: font, backgroundColor: Colors.green),
                  onPressed: _started
                      ? () {
                          _saveEvent(EventType.smallMistake);
                        }
                      : null,
                  child: Text(textAlign: TextAlign.center, 'Small: $_small'),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(textStyle: font, backgroundColor: Colors.red),
                  onPressed: _started
                      ? () {
                          _saveEvent(EventType.majorMistake);
                        }
                      : null,
                  child: Text(textAlign: TextAlign.center, 'Major: $_major'),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(textStyle: font, backgroundColor: Colors.amber),
                  onPressed: _started
                      ? () {
                          _saveEvent(EventType.obviousMistake);
                        }
                      : null,
                  child: Text(textAlign: TextAlign.center, 'Obvious: $_obvious'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
