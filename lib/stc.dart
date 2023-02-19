import 'package:artistic_swimming_app/model/event.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dao/event_dao.dart';

class StcPage extends StatefulWidget {
  const StcPage({super.key});

  String get title => "Synchronization Technical Controller";

  @override
  State<StcPage> createState() => StcPageState();
}

class StcPageState extends State<StcPage> {
  bool _started = false;

  _toggleStarted() {
    _saveEvent(_started ? EventType.start : EventType.stop);
    setState(() {
      _started = !_started;
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
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(textStyle: font, backgroundColor: Colors.green),
                  onPressed: _started
                      ? () {
                          _saveEvent(EventType.smallMistake);
                        }
                      : null,
                  child: const Text(textAlign: TextAlign.center, 'Small'),
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
                  child: const Text(textAlign: TextAlign.center, 'Major'),
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
                  child: const Text(textAlign: TextAlign.center, 'Obvious'),
                ),
              ), //Flex
            ],
          ),
        ),
      ),
    );
  }
}
