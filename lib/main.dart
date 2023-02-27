import 'package:artistic_swimming_app/dao/event_dao.dart';
import 'package:artistic_swimming_app/dao/user_dao.dart';
import 'package:artistic_swimming_app/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => EventDao()),
        Provider(create: (context) => UserDao()),
      ],
      child: const ArtisticSwimmingApp(),
    ),
  );
}

class ArtisticSwimmingApp extends StatelessWidget {
  const ArtisticSwimmingApp({super.key});

  @override
  Widget build(BuildContext context) {
    _landscapeModeOnly();
    return MaterialApp(
      title: 'Synchro Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }

  void _landscapeModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }
}
