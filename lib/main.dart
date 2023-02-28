import 'package:artistic_swimming_app/dao/event_dao.dart';
import 'package:artistic_swimming_app/dao/user_dao.dart';
import 'package:artistic_swimming_app/login.dart';
import 'package:artistic_swimming_app/repository/export_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
    final userDao = UserDao();
    final exportRepository = ExportRepository(eventDao: eventDao, userDao: userDao);

    _landscapeModeOnly();
    return MultiProvider(
      providers: [
        Provider(create: (context) => eventDao),
        Provider(create: (context) => userDao),
        Provider(create: (context) => exportRepository),
      ],
      child: MaterialApp(
        title: 'Synchro Timer',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LoginPage(),
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
