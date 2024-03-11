import 'package:artistic_swimming_app/dao/event_dao.dart';
import 'package:artistic_swimming_app/dao/session_dao.dart';
import 'package:artistic_swimming_app/repository/export_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'home.dart';

void main() {
  runApp(
    const ArtisticSwimmingApp(),
  );
}

class ArtisticSwimmingApp extends StatelessWidget {
  const ArtisticSwimmingApp({super.key});

  @override
  Widget build(BuildContext context) {
    final eventDao = EventDao();
    final sessionDao = SessionDao();

    final exportRepository = ExportRepository(eventDao: eventDao);

    _landscapeModeOnly();
    return MultiProvider(
      providers: [
        Provider(create: (context) => eventDao),
        Provider(create: (context) => sessionDao),
        Provider(create: (context) => exportRepository),
      ],
      child: MaterialApp(
        title: 'Synchro Timer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const SynchroHomePage(),
      ),
    );
  }

  void _landscapeModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
