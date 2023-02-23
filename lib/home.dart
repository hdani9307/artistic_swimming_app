import 'package:artistic_swimming_app/stc.dart';
import 'package:flutter/material.dart';

import 'dtc.dart';

class SynchroHomePage extends StatefulWidget {
  const SynchroHomePage({super.key});

  String get title => "Synchro Timer";

  @override
  State<SynchroHomePage> createState() => _SynchroHomePageState();
}

class _SynchroHomePageState extends State<SynchroHomePage> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                  style: style,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const StcPage()),
                    );
                  },
                  child: const Text(textAlign: TextAlign.center, 'Synchronization Technical Controller'),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: ElevatedButton(
                  style: style,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DtcPage()),
                    );
                  },
                  child: const Text(textAlign: TextAlign.center, 'Difficulty Technical Controller'),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: ElevatedButton(
                  style: style,
                  onPressed: () {},
                  child: const Text(textAlign: TextAlign.center, 'Dashboard'),
                ),
              ), //Flex
            ],
          ),
        ),
      ),
    );
  }
}
